#!/usr/bin/env bash
set -euo pipefail
python - <<'PY'
from pathlib import Path
s=Path('index.html').read_text()
start=s.rfind('<script>')+8
end=s.rfind('</script>')
Path('/tmp/the_turn_app.js').write_text(s[start:end])
print('extracted_js', end-start)
PY
node --check /tmp/the_turn_app.js
python -m json.tool manifest.webmanifest >/dev/null
rg -n "setup-progress|score-toolbar|result-kpis|Private Access|serviceWorker.register" index.html >/dev/null
echo "phase3-smoke-check: PASS"
