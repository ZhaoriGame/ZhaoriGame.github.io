#!/usr/bin/env bash
set -euo pipefail

# Create/update a Hexo post, commit, push a branch, and open a PR.
# Usage:
#   scripts/blog-post.sh --title "My Title" --tags "AI,Hexo" --content-file /path/to/post.md

TITLE=""
TAGS=""
CATEGORIES=""
CONTENT_FILE=""
DATE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --title) TITLE="$2"; shift 2;;
    --tags) TAGS="$2"; shift 2;;
    --categories) CATEGORIES="$2"; shift 2;;
    --content-file) CONTENT_FILE="$2"; shift 2;;
    --date) DATE="$2"; shift 2;;
    *) echo "Unknown arg: $1" >&2; exit 2;;
  esac
done

if [[ -z "$TITLE" || -z "$TAGS" || -z "$CONTENT_FILE" ]]; then
  echo "Missing required args: --title, --tags, --content-file" >&2
  exit 2
fi

if [[ ! -f "$CONTENT_FILE" ]]; then
  echo "content file not found: $CONTENT_FILE" >&2
  exit 2
fi

if [[ -z "$DATE" ]]; then
  DATE=$(TZ=Asia/Shanghai date '+%Y-%m-%d %H:%M:%S')
fi

# Repo conventions:
# - Posts live in source/_posts/<title>.md
# - Title impacts permalink (:title)
POST_PATH="source/_posts/${TITLE}.md"

# Simple slug for branch names (ASCII only)
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr -cs 'a-z0-9' '-' | sed 's/^-//;s/-$//')
if [[ -z "$SLUG" ]]; then
  SLUG="post"
fi
BRANCH="blog/$(TZ=Asia/Shanghai date +%F)/${SLUG}"

git checkout hexo

git pull --ff-only origin hexo

git checkout -b "$BRANCH"

# Build frontmatter in the repo's YAML style.
{
  echo "---"
  echo "title: ${TITLE}"
  echo "date: ${DATE}"
  echo "tags:"
  IFS=',' read -ra tagarr <<<"$TAGS"
  for t in "${tagarr[@]}"; do
    t=$(echo "$t" | xargs)
    [[ -z "$t" ]] && continue
    echo "  - ${t}"
  done
  if [[ -n "$CATEGORIES" ]]; then
    echo "categories:"
    IFS=',' read -ra catarr <<<"$CATEGORIES"
    for c in "${catarr[@]}"; do
      c=$(echo "$c" | xargs)
      [[ -z "$c" ]] && continue
      echo "  - ${c}"
    done
  fi
  echo "---"
  echo
  cat "$CONTENT_FILE"
} > "$POST_PATH"

npm install
npx hexo clean && npx hexo generate

test -s public/index.html

git add "$POST_PATH"

git commit -m "blog: add ${SLUG}"

git push -u origin "$BRANCH"

# Open PR (requires gh auth).
PR_URL=$(gh pr create --repo ZhaoriGame/ZhaoriGame.github.io --head "$BRANCH" --base hexo --title "blog: ${TITLE}" --body "Adds post: ${TITLE}." )

echo "$PR_URL"
