#!/usr/bin/env bash
set -e

echo "Comparing tags…"
dups=.git/refs/upstream/tags/
dmir=.git/refs/mirror/tags/
for fpath in ${dups}*; do
  tag=${fpath#${dups}}
  if [ ! -e "${dmir}${tag}" ]; then
    echo "Identified new tag ${tag}"

    # Push tag to mirror
    echo "Pushing tag to mirror…"
    git push origin refs/upstream/tags/${tag}:refs/tags/${tag}

    echo "Creating new release…"
    echo "gh release create \"$tag\""
    gh release create "$tag"
  fi
done
