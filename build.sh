sudo apt-get update
sudo apt-get install aptitude -y
sudo aptitude update
sudo aptitude install build-essential libcups2-dev libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev libasound2-dev libfontconfig1-dev python3 ccache autoconf -y
git submodule update --init
wget -N https://github.com/graalvm/labs-openjdk-11/releases/download/jvmci-19.3-b04/labsjdk-ce-11.0.5+10-jvmci-19.3-b04-fastdebug-linux-amd64.tar.gz
tar -xf labsjdk-ce-11.0.5+10-jvmci-19.3-b04-fastdebug-linux-amd64.tar.gz
wget -N https://ci.adoptopenjdk.net/view/Dependencies/job/jtreg/lastSuccessfulBuild/artifact/jtreg-5.1-b01.tar.gz
tar -xf jtreg-5.1-b01.tar.gz
cd labs-openjdk-11
\cp ..//build_labsjdk.py build_labsjdk.py
python build_labsjdk.py --configure-option=--disable-warnings-as-errors --boot-jdk=..//labsjdk-ce-11.0.5-jvmci-19.3-b04-fastdebug/ \
--configure-option="--with-extra-cxxflags=-Ofast -march=native -mtune=native -funroll-loops -fomit-frame-pointer -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt -fopenmp -pthread -Wno-deprecated" \
--configure-option="--with-extra-cflags=-Ofast -march=native -mtune=native -funroll-loops -fomit-frame-pointer -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt -fopenmp -pthread -Wno-deprecated" \
--configure-option=--with-jvm-features=link-time-opt --configure-option=--enable-ccache --configure-option=--with-jtreg=..//jtreg/
./build/*/images/jdk/bin/java -version
make run-test-tier1