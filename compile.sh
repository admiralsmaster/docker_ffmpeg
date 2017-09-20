#!/bin/bash

mkdir ~/ffmpeg_sources


cd ~/ffmpeg_sources
wget http://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin"
make
make install


cd ~/ffmpeg_sources
wget http://download.videolan.org/pub/x264/snapshots/last_x264.tar.bz2
tar xjvf last_x264.tar.bz2
cd x264-snapshot*
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static --disable-opencl
PATH="$HOME/bin:$PATH" make
make install


cd ~/ffmpeg_sources
hg clone https://bitbucket.org/multicoreware/x265
cd ~/ffmpeg_sources/x265/build/linux
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install


cd ~/ffmpeg_sources
wget -O fdk-aac.tar.gz https://github.com/mstorsjo/fdk-aac/tarball/master
tar xzvf fdk-aac.tar.gz
cd mstorsjo-fdk-aac*
autoreconf -fiv
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install


cd ~/ffmpeg_sources
wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz
tar xzvf lame-3.99.5.tar.gz
cd lame-3.99.5
./configure --prefix="$HOME/ffmpeg_build" --enable-nasm --disable-shared
make
make install


cd ~/ffmpeg_sources
wget http://downloads.xiph.org/releases/opus/opus-1.1.4.tar.gz
tar xzvf opus-1.1.4.tar.gz
cd opus-1.1.4
./configure --prefix="$HOME/ffmpeg_build" --disable-shared
make
make install


cd ~/ffmpeg_sources
wget http://storage.googleapis.com/downloads.webmproject.org/releases/webm/libvpx-1.6.1.tar.bz2
tar xjvf libvpx-1.6.1.tar.bz2
cd libvpx-1.6.1
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --disable-examples --disable-unit-tests
PATH="$HOME/bin:$PATH" make
make install




cd ~/ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
--prefix="$HOME/ffmpeg_build" \
--pkg-config-flags="--static" \
--extra-cflags="-I$HOME/ffmpeg_build/include" \
--extra-ldflags="-L$HOME/ffmpeg_build/lib" \
--bindir="$HOME/bin" \
--enable-gpl \
--enable-libass \
--enable-libfdk-aac \
--enable-libfreetype \
--enable-libmp3lame \
--enable-libopus \
--enable-libtheora \
--enable-libvorbis \
--enable-libvpx \
--enable-libx264 \
--enable-libx265 \
--enable-nonfree \
--enable-avresample \
--enable-avisynth \
--enable-ladspa  \
--enable-libbs2b \
--enable-libcaca --enable-libcdio --enable-libfontconfig \
--enable-libfribidi --enable-libgme --enable-libgsm \
--enable-libmodplug --enable-libopenjpeg \
--enable-libpulse --enable-librtmp \
--enable-libshine --enable-libsnappy --enable-libsoxr \
--enable-libspeex --enable-libssh \
--enable-libtwolame \
--enable-libwavpack --enable-libwebp --enable-libxvid \
--enable-libzvbi --enable-openal --enable-opengl \
--enable-libdc1394 --enable-libiec61883 --enable-libzmq --enable-frei0r \
--enable-libopencv \
--disable-stripping --disable-decoder=libopenjpeg \
--enable-gnutls \
--enable-libflite
#--enable-libbluray
#--enable-x11grab
#--enable-libschroedinger
#--disable-decoder=libschroedinger \
PATH="$HOME/bin:$PATH" make
make install
hash -r


# create manual folder and copy created manuals into it
mkdir ~/man
mv -fv ~/ffmpeg_build/share/man/* ~/man

# remove source and build folder
rm -rf ~/ffmpeg_build ~/ffmpeg_sources

# set PATH and MANPATH
echo "export PATH=\${PATH}:$HOME/bin/" >> $HOME/.profile
echo "export MANPATH=\${MANPATH}:$HOME/man" >> $HOME/.profile
