# Copyright (c) 2025 VEXXHOST, Inc.
# SPDX-License-Identifier: Apache-2.0

# versions_since REPO MIN_VERSION [tag_prefix=v]
# - REPO: org/name, e.g. "kubernetes-sigs/cri-tools"
# - MIN_VERSION: "1.28.0" (no leading 'v')
# - tag_prefix: tag prefix to strip/match (default "v"); set "" if none
versions_since() {
  local repo="$1"
  local min_ver="$2"   # e.g. 1.28.0
  local tag_prefix="${3:-v}"

  # break down MIN_VERSION into major/minor/patch
  local MIN_MAJOR MIN_MINOR MIN_PATCH
  IFS='.' read -r MIN_MAJOR MIN_MINOR MIN_PATCH <<<"$min_ver"

  gh api "repos/${repo}/tags" --paginate \
  | jq -r --argjson min_major "$MIN_MAJOR" \
           --argjson min_minor "$MIN_MINOR" \
           --argjson min_patch "$MIN_PATCH" \
           --arg prefix "$tag_prefix" '
      [ .[].name
        | select(test("^" + $prefix + "[0-9]+\\.[0-9]+\\.[0-9]+$"))
        | ltrimstr($prefix)
        | capture("^(?<major>[0-9]+)\\.(?<minor>[0-9]+)\\.(?<patch>[0-9]+)$")
        | .major |= tonumber
        | .minor |= tonumber
        | .patch |= tonumber
      ]
      | sort_by(.major, .minor, .patch)
      | map(select(
          (.major > $min_major)
          or (.major == $min_major and .minor > $min_minor)
          or (.major == $min_major and .minor == $min_minor and .patch >= $min_patch)
        ))
      | map("\(.major).\(.minor).\(.patch)")
      | .[]
  '
}
