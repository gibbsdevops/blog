#!/bin/bash

cp images/profile.svg images/favicons/safari-pinned-tab.svg

do_convert() {
  out="$1"
  width="$2"
  if [ -z "$3" ]; then
    height="$width"
  else
    height="$3"
  fi
  convert +antialias -background transparent images/profile.svg -gravity center -resize "${width}x${height}" -extent "${width}x${height}" "images/favicons/$out"
}

sizes=( 36 48 72 96 144 192 )
for s in "${sizes[@]}"; do
  do_convert "android-chrome-${s}x${s}.png" "$s"
done

sizes=( 57 60 72 76 114 120 144 152 180 )
for s in "${sizes[@]}"; do
  do_convert "apple-touch-icon-${s}x${s}.png" "$s"
done
do_convert "apple-touch-icon.png" 180
do_convert "apple-touch-icon-precomposed.png" 180

sizes=( 16 32 96 194 )
for s in "${sizes[@]}"; do
  do_convert "favicon-${s}x${s}.png" "$s"
done
do_convert favicon.ico 48

sizes=( 70 144 150 310 )
for s in "${sizes[@]}"; do
  do_convert "mstile-${s}x${s}.png" "$s"
done
do_convert "mstile-310x150.png" 310 150
