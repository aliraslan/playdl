#!/bin/bash
PlayName=$(zenity --entry --title="Playlist title?" --text="Title: ")
PlayLink=$(zenity --entry --title="Please enter the YouTube url" --text="Link: ")
Location=$(zenity --file-selection --directory)
cd $Location &&
mkdir $PlayName &&
cd $PlayName &&
mkdir Audio &&
cd Audio &&
(youtube-dl -c -x --retries infinite --audio-quality 0 --add-metadata --xattrs -o '%(autonumber)s-%(title)s.%(ext)s' https://www.youtube.com/playlist?list=$PlayLink) |
zenity --progress \
	--title="Downloading audio" \
	--text="Fetching files from YouTube..." \
	--percentage=0 \
	--pulsate \
	--auto-close \
	--auto-kill \
	--time-remaining
if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Download canceled."
fi
cd .. &&
mkdir Video &&
cd Video &&
(youtube-dl -c --retries infinite --audio-quality 0 --add-metadata --xattrs -o '%(autonumber)s-%(title)s.%(ext)s' https://www.youtube.com/playlist?list=$PlayLink) |
zenity --progress \
	--title="Downloading video" \
	--text="Fetching videos from YouTube..." \
	--percentage=0 \
	--pulsate \
	--auto-close \
	--auto-kill \
	--time-remaining
if [ "$?" = -1 ] ; then
        zenity --error \
          --text="Download canceled."
fi
zenity --info --text="Success."
