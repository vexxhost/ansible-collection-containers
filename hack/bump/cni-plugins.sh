set -euo pipefail

FILE=${1:-roles/cni_plugins/defaults/main.yml}

mapfile -t VERSIONS < <(
  gh api repos/containernetworking/plugins/tags --paginate \
  | jq -r '
      [ .[].name
        | capture("^v(?<major>1)\\.(?<minor>\\d+)\\.(?<patch>\\d+)$")
        | .minor |= tonumber
        | .patch |= tonumber
      ]
      | map(select(.minor >= 3))
      | sort_by(.minor, .patch)
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
        echo "    v${v}: $(curl -sSL "https://github.com/containernetworking/plugins/releases/download/v${v}/cni-plugins-linux-${arch}-v${v}.tgz.sha256" | awk '{print $1}')"
      done
    done
  }
}

CNI_BLOCK=$(gen_block | grep -v Not)

awk -i inplace -v cni_block="$CNI_BLOCK" '
function print_block(s) { printf "%s\n\n", s }
BEGIN { in_cni=0 }
# Start of the checksums map
/^cni_plugins_checksums:\s*$/ {
  print
  print_block(cni_block)
  in_cni=1
  next
}
# Any new top-level line ends the block
/^[^[:space:]]/ {
  if (in_cni) in_cni=0
  print
  next
}
# Skip original lines while inside the block
in_cni { next }
# Default passthrough
{ print }
' "$FILE"

echo "Updated $FILE with CNI plugin checksums (>= v1.3.0)."
