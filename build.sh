sudo apt-get update
sudo apt-get install aptitude -y
sudo aptitude update
sudo aptitude install build-essential libcups2-dev libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev libasound2-dev libfontconfig1-dev python3 ccache autoconf -y
git submodule update --init
wget -N https://github.com/graalvm/labs-openjdk-11/releases/download/jvmci-20.3-b01/labsjdk-ce-11.0.8+10-jvmci-20.3-b01-debug-linux-amd64.tar.gz
tar -xf labsjdk-ce-11.0.8+10-jvmci-20.3-b01-debug-linux-amd64.tar.gz
wget -N https://ci.adoptopenjdk.net/view/Dependencies/job/jtreg/lastSuccessfulBuild/artifact/jtreg-5.1-b01.tar.gz
tar -xf jtreg-5.1-b01.tar.gz
cd labs-openjdk-11
git pull
git reset master
python build_labsjdk.py --configure-option=--disable-warnings-as-errors --boot-jdk=..//labsjdk-ce-11.0.8-jvmci-20.3-b01-debug/ \
--configure-option="--with-extra-cxxflags=-O3 -fgraphite-identity -floop-nest-optimize -fdevirtualize-at-ltrans -fipa-pta -fno-semantic-interposition -fuse-linker-plugin -O3 -march=native -mtune=native -pipe -w" \
--configure-option="--with-extra-cflags=-O3 -fgraphite-identity -floop-nest-optimize -fdevirtualize-at-ltrans -fipa-pta -fno-semantic-interposition -fuse-linker-plugin -O3 -march=native -mtune=native -pipe -w" \
--configure-option="--with-extra-ldflags=-O3 -fgraphite-identity -floop-nest-optimize -fdevirtualize-at-ltrans -fipa-pta -fno-semantic-interposition -fuse-linker-plugin -O3 -march=native -mtune=native -pipe -w" \
--configure-option=--with-jvm-features=link-time-opt --configure-option=--enable-ccache \
--configure-option=--with-jtreg=..//jtreg/