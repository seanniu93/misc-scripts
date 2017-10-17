#!/bin/bash
#
# Requires
#  - GNU Parallel
#  - ffmpeg

# This uses the highest quality VBR.
# If you want 320Kbps CBR, replace "-q:a 0" with "-b:a 320k"
parallel ffmpeg -i {} -q:a 0 {.}.mp3 ::: *.flac
