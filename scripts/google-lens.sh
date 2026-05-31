#!/bin/bash

grim -g "$(slurp)" /tmp/g.png && curl -sF 'files[]=@/tmp/g.png' https://uguu.se/upload | jq -r '.files[0].url' | xargs -I{} xdg-open "https://lens.google.com/uploadbyurl?url={}"
