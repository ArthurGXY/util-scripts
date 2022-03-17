#!/usr/bin/env bash
DST_DIR=$HOME/图片/screenshots
if [[ ! -d DST_DIR ]]; then
    mkdir $DST_DIR
fi


FILE=$HOME/图片/screenshots/screenshot_$(date "+%Y_%m%d-%H%M%S").png
#grim -g "$(slurp)" "$FILE"
#wl-copy < "$FILE"
grimblast --freeze copysave area "$FILE"

# Send the notification with an action
ACTION=$(dunstify -a "Simple Screen Shot" "Screenshot Taken" \
  "Click to open in Thunar or view." \
  --action="openThunar,Show folder" \
  --action="openImg,View" \
  --action="editImg,Edit" \
  --icon="folder")

# If the user clicked "Open Folder", open Thunar
if [[ "$ACTION" == "openThunar" ]]; then
  # thunar "$(dirname "$FILE")"  # Opens the folder containing the file
  thunar "$FILE"
  # OR: `thunar "$TARGET_PATH"` to open the file directly
elif [[ "$ACTION" == "openImg" ]]; then
    feh "$FILE"
elif [[ "$ACTION" == "editImg" ]]; then
    annotator "$FILE"
fi
