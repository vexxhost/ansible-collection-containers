# Copyright (c) 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

source "$(dirname "$0")/lib.sh"

FILE=${1:-roles/runc/defaults/main.yml}

mapfile -t VERSIONS < <(versions_since "opencontainers/runc" "1.1.13")

gen_block () {
  local arch
  {
    for arch in amd64 arm64; do
      echo "  ${arch}:"
      for v in "${VERSIONS[@]}"; do
        echo "    v${v}: $(curl -sSL "https://github.com/opencontainers/runc/releases/download/v${v}/runc.sha256sum" | grep "${arch}" | awk '{print $1}')"
      done
    done
  }
}

RUNC_BLOCK=$(gen_block)

awk -i inplace -v runc_block="$RUNC_BLOCK" '
function print_block(s) { printf "%s\n\n", s }
BEGIN { in_runc=0 }
# Start of the checksums map
/^runc_checksums:\s*$/ {
  print
  print_block(runc_block)
  in_runc=1
  next
}
# Any new top-level line ends the block
/^[^[:space:]]/ {
  if (in_runc) in_runc=0
  print
  next
}
# Skip original lines while inside the block
in_runc { next }
# Default passthrough
{ print }
' "$FILE"

echo "Updated $FILE with runc checksums (>= v1.1.13)."
