return {
  s('#!shebang', { t({ '#!/usr/bin/env bash', 'set -euo pipefail', '', '' }), i(0) }),
  s('# shellcheck disable=', { t('# shellcheck disable='), i(0) }),
}
