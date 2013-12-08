twonkyserver-apkg
=================

Build Twonkyserver package for ASUSTOR NAS 

# Build Twonkyserver package #

run `bin/apkg-create-package.sh --help` to see how to invoke the script.

Example: `bin/apkg-create-package.sh i386`. That will create the Optware package for the i386 based ASUSTOR NAS, like AS-20xT/TE and AS-30xT. The *.apk file will be copied to the current directory and has date/time added to it's name to prevent overwritting existing files.

The `source` directory contains all files needed for Twonkyserver's ipkg to run on i386 or x86_64 based ASUSTOR NAS'. Except the Twonkyserver files itself. You can download them on the [Twonkyserver NAS Download page](http://www.twonkyforum.com/downloads/7.2.6-2/), [32-bit](http://www.twonkyforum.com/downloads/7.2.6-2/twonky-i686-glibc-2.9-7.2.6-2.zip) or [64-bit](http://www.twonkyforum.com/downloads/7.2.6-2/twonky-x86-64-glibc-2.9-7.2.6-2.zip). Unzip the content into the `source/twonkyserver-i386` or `source/twonkyserver-x86-64` and run the `bin/apkg-create-package.sh` script

The `bin-{i386,x86-64}` folders do contain the helper ffmpeg, convert & flac.
