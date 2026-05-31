#!/usr/bin/env bash
# QuickSnip Google Lens launcher (newtab mode only).
# Args: <full_png> <x> <y> <w> <h> <crop_jpg> <lens_html>
# Crops region, builds an HTML form that auto-POSTs to Google Lens, opens via xdg-open.

set -uo pipefail

if [ "$#" -lt 7 ]; then
    echo "usage: $0 full_png x y w h crop_jpg lens_html" >&2
    exit 64
fi

FULL=$1; CX=$2; CY=$3; CW=$4; CH=$5; CROP=$6; HTML=$7

magick "$FULL" -crop "${CW}x${CH}+${CX}+${CY}" -resize '1000x1000>' -strip -quality 85 "$CROP" || exit 1

B64=$(base64 -w0 "$CROP" 2>/dev/null || base64 -b0 "$CROP")

cat >"$HTML" <<HTML_EOF
<html><body style="margin:0;display:flex;justify-content:center;align-items:center;height:100vh;background:#111;color:#fff;font-family:system-ui">
<p>Searching with Google Lens…</p>
<form id="f" method="POST" enctype="multipart/form-data" action="https://lens.google.com/v3/upload"></form>
<script>
var b=atob('$B64');
var a=new Uint8Array(b.length);for(var i=0;i<b.length;i++)a[i]=b.charCodeAt(i);
var d=new DataTransfer();d.items.add(new File([a],"i.jpg",{type:"image/jpeg"}));
var inp=document.createElement("input");inp.type="file";inp.name="encoded_image";
inp.files=d.files;document.getElementById("f").appendChild(inp);
document.getElementById("f").submit();
</script>
</body></html>
HTML_EOF

xdg-open "$HTML" >/dev/null 2>&1

# Self-clean after 15s so the user's browser has time to fetch the form.
( sleep 15 && rm -f "$FULL" "$CROP" "$HTML" ) >/dev/null 2>&1 &
disown
