#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
marimo export html-wasm demo_marimo.py -o ../docs --mode run -f
python3 -c "
path='../docs/index.html'
with open(path) as f: html = f.read()
# auto_instantiate defaults to false; force true so the demo runs immediately on load
html = html.replace('\"auto_instantiate\": false', '\"auto_instantiate\": true', 1)
# The lloyd animation + plotly figures exceed the default 8MB cap; raise to 64MB
html = html.replace('\"output_max_bytes\": 8000000', '\"output_max_bytes\": 67108864', 1)
with open(path, 'w') as f: f.write(html)
print('Patched: auto_instantiate=true, output_max_bytes=64MB')
"
echo "Done — serve with: python -m http.server --directory ../docs"
