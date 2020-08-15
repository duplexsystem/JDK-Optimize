sudo apt-get install aptitude -y
sudo aptitude install build-essential libcups2-dev openjdk-11-jdk libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev libasound2-dev libfontconfig1-dev autoconf -y
git submodule update --init
wget -N https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.8%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.8_10.tar.gz
tar -xf OpenJDK11U-jdk_x64_linux_hotspot_11.0.8_10.tar.gz
wget -N https://ci.adoptopenjdk.net/view/Dependencies/job/jtreg/lastSuccessfulBuild/artifact/jtreg-5.1-b01.tar.gz
tar -xf jtreg-5.1-b01.tar.gz
cd jdk11u
bash configure --with-jvm-variants=server --with-jvm-features=link-time-opt --enable-ccache --with-boot-jdk=..//jdk-11.0.8+10/ --with-jtreg=..//jtreg/ \
--with-extra-cflags='-w' \
--with-extra-cxxflags='-w'
make clean
make images
./build/*/images/jdk/bin/java -version
make run-test-tier1