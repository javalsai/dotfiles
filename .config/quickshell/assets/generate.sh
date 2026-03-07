#!/usr/bin/env bash
set -euo pipefail

echo "${1:-}"/* > "${2:-gifs.list}"
