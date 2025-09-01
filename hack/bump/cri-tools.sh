set -euo pipefail

FILE=${1:-roles/cri_tools/defaults/main.yml}

mapfile -t VERSIONS < <(
  gh api repos/kubernetes-sigs/cri-tools/tags --paginate \
  | jq -r '
      [ .[].name
        | capture("^v(?<major>1)\\.(?<minor>\\d+)\\.(?<patch>\\d+)$")
        | .minor |= tonumber
        | .patch |= tonumber
      ]
      | map(select(.minor >= 28))
      | sort_by(.minor, .patch)
      | map("1." + (.minor|tostring) + "." + (.patch|tostring))
      | .[]
  '
)

gen_block () {
  local tool="$1"
  local arch
  {
    for arch in amd64 arm64; do
      echo "  ${arch}:"
      for v in "${VERSIONS[@]}"; do
        echo "    ${v}: $(curl -sSL "https://github.com/kubernetes-sigs/cri-tools/releases/download/v${v}/${tool}-v${v}-linux-${arch}.tar.gz.sha256" | awk '{print $1}')"
      done
    done
  }
}

CRICTL_BLOCK=$(gen_block crictl)
CRITEST_BLOCK=$(gen_block critest)

awk -i inplace \
  -v crictl_block="$CRICTL_BLOCK" \
  -v critest_block="$CRITEST_BLOCK" '
function print_block(s) { printf("%s\n\n", s); }

BEGIN {
  in_crictl = 0
  in_critest = 0
  printed_crictl = 0
  printed_critest = 0
}

# Start of crictl checksums
/^cri_tools_crictl_checksums:\s*$/ {
  print
  print_block(crictl_block)
  in_crictl = 1
  printed_crictl = 1
  next
}

# Start of critest checksums
/^cri_tools_critest_checksums:\s*$/ {
  print
  print_block(critest_block)
  in_critest = 1
  printed_critest = 1
  next
}

# End of either block when we reach any non-indented line (next top-level key or comment)
/^[^[:space:]]/ {
  if (in_crictl)  { in_crictl = 0 }
  if (in_critest) { in_critest = 0 }
  print
  next
}

# While inside either block, skip original lines
(in_crictl || in_critest) { next }

# Default: pass-through
{ print }

END {
  # If a block ran to EOF (rare), we already printed the new block above.
}
' "$FILE"

echo "Updated $FILE with cri-tools checksums since v1.28.0."
