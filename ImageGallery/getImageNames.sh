#!/bin/sh

#  getImageNames.sh
#  ImageGallery
#
#  Created by Gabriel Betancourt on 9/2/20.
#  Copyright © 2020 mau5atron. All rights reserved.

# clear out the imageNames.txt file
#: > imageNames.txt
: > ./ImageGallery/imageNames.txt

# use this for checking within the ImageGallery folder (dev)
#for FILE in ./Assets.xcassets/*; do
#	if [[ $FILE == *.imageset ]]; then
#		echo $FILE >> imageNames.txt
#	fi
#done;

# use this in the pre-actions
for FILE in ./ImageGallery/Assets.xcassets/*; do
	if [[ $FILE == *.imageset ]]; then
		echo $FILE >> ./ImageGallery/imageNames.txt
	fi
done;
