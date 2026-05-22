#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
marimo export html-wasm demo_marimo.py -o ../docs --mode run -f
# auto_instantiate defaults to false; force true so the demo runs immediately on load
python3 -c "
path='../docs/index.html'
with open(path) as f: html = f.read()
html = html.replace('\"auto_instantiate\": false', '\"auto_instantiate\": true', 1)
with open(path, 'w') as f: f.write(html)
print('Patched auto_instantiate -> true')
"
echo "Done — serve with: python -m http.server --directory ../docs"
