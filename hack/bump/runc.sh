set -euo pipefail

FILE=${1:-roles/runc/defaults/main.yml}

mapfile -t VERSIONS < <(
  gh api repos/opencontainers/runc/tags --paginate \
  | jq -r '
      [ .[].name
        | capture("^v(?<major>\\d+)\\.(?<minor>\\d+)\\.(?<patch>\\d+)$")
        | .major |= tonumber
        | .minor |= tonumber
        | .patch |= tonumber
      ]
      | sort_by(.major, .minor, .patch)
      | map(select(
          (.major > 1)
          or (.major == 1 and .minor > 1)
          or (.major == 1 and .minor == 1 and .patch > 13)
        ))
      | map("1." + (.minor|tostring) + "." + (.patch|tostring))
      | .[]
  '
)

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
