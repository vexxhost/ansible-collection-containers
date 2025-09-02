# Copyright (c) 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

source "$(dirname "$0")/lib.sh"

FILE=${1:-roles/containerd/defaults/main.yml}

mapfile -t VERSIONS < <(versions_since "containerd/containerd" "1.7.17")

gen_block () {
  local arch
  {
    for arch in amd64 arm64; do
      echo "  ${arch}:"
      for v in "${VERSIONS[@]}"; do
        echo "    ${v}: $(curl -sSL "https://github.com/containerd/containerd/releases/download/v${v}/containerd-${v}-linux-${arch}.tar.gz.sha256sum" | awk '{print $1}')"
      done
    done
  }
}

CONTAINERD_BLOCK=$(gen_block | egrep -v ": $")

awk -i inplace -v containerd_block="$CONTAINERD_BLOCK" '
function print_block(s) { printf "%s\n\n", s }
BEGIN { in_containerd=0 }
# Start of the checksums map
/^containerd_archive_checksums:\s*$/ {
  print
  print_block(containerd_block)
  in_containerd=1
  next
}
# Any new top-level line ends the block
/^[^[:space:]]/ {
  if (in_containerd) in_containerd=0
  print
  next
}
# Skip original lines while inside the block
in_containerd { next }
# Default passthrough
{ print }
' "$FILE"

echo "Updated $FILE with containerd checksums (>= v1.7.17)."
