#!/bin/bash
# Run this to install the things that I always want installed
# These should all work for trusty tapr
# Uncomment the you want and then run this script, should be simple enough
#
# Basic things that I need/want
#sudo apt-get install su sleep vim curl tmux zsh xcliP gliv ranger rifle luakit
# Awesome, its dependencies, and some other things I use with it
#sudo apt-get install awesome awesome-extra build-essential libxinerama-dev libxrandr-dev libcairo2-dev libxft-dev libconfuse-dev asciidoc xmlto doxygen pulseaudio

# This is an awesome dependency not in aptitude
#cd $USER/Downloads
#curl -O http://bzero.se/confuse/confuse-2.6.tar.gz
#tar xf confuse-2.6.tar.gz
#cd confuse-2.6
#./configure && make && sudo make install && cd

# Adobe Flash
#sudo apt-get install flashplugin-installer
# Command-line games
# sudo apt-get install nethack netris greed

# Command-line Pandora.com client and dependencies
#sudo apt-get install pianobar yasm libao-dev libgcrypt11-dev libgnutls-dev libfaad-dev libmad0-dev libjson0-dev pkg-config
## Install FFmpeg (it's a dependency
#git clone https://github.com/FFmpeg/FFmpeg.git $USER/Downloads/ffmpeg
#cd $USER/Downloads/ffmpeg
#./configure
#make clean
#make
#sudo make install
#cd -
# Music tools: player, volume mormalizer, audio editor, audio converter
#sudo apt-get cmus mp3gain lame avconv
# Pip things
#sudo apt-get install pip pip3
#sudo pip install mpsyt ipython
