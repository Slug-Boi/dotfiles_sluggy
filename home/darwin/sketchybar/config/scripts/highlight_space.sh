#SID=$(echo $INFO | jq .[\"display-1\"])
if [ "$SID" = "" ]; then
    SID=$(aerospace list-workspaces --focused)
fi
LENGTH=$($(echo aerospace list-workspaces --all --count) | jq length)

# Very magic number heavy but it seems to work. Not sure how to make it more dynamic
export LENGTH=$((-(LENGTH - (SID - 1)) * 30 + 2))
if [ "$SID" -eq 1 ]; then LENGTH=$((LENGTH + 4)); fi # This is a hack to make the first workspace look better
sketchybar --set highlight_space icon=""

sketchybar --animate circ 15 --set highlight_space background.padding_left=$LENGTH \

sketchybar --set highlight_space icon=$SID \
                             icon.align=center \
                             icon.width=22

