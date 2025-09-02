# Copyright (c) 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

source "$(dirname "$0")/lib.sh"

FILE=${1:-roles/nerdctl/defaults/main.yml}

mapfile -t VERSIONS < <(versions_since "containerd/nerdctl" "1.7.4")

gen_block () {
  local arch
  {
    for arch in amd64 arm64; do
      echo "  ${arch}:"
      for v in "${VERSIONS[@]}"; do
        echo "    ${v}: $(curl -sSL "https://github.com/containerd/nerdctl/releases/download/v${v}/SHA256SUMS" | grep "nerdctl-${v}-linux-${arch}.tar.gz" | awk '{print $1}')"
      done
    done
  }
}

NERDCTL_BLOCK=$(gen_block | egrep -v ": $")

awk -i inplace -v nerdctl_block="$NERDCTL_BLOCK" '
function print_block(s) { printf "%s\n\n", s }
BEGIN { in_nerdctl=0 }
# Start of the checksums map
/^nerdctl_checksums:\s*$/ {
  print
  print_block(nerdctl_block)
  in_nerdctl=1
  next
}
# Any new top-level line ends the block
/^[^[:space:]]/ {
  if (in_nerdctl) in_nerdctl=0
  print
  next
}
# Skip original lines while inside the block
in_nerdctl { next }
# Default passthrough
{ print }
' "$FILE"

echo "Updated $FILE with nerdctl checksums (>= v1.7.4)."
