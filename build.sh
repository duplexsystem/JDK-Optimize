sudo apt-get update
sudo apt-get install aptitude -y
sudo aptitude update
sudo aptitude install build-essential libcups2-dev openjdk-11-jdk libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev libasound2-dev libfontconfig1-dev python3 autoconf -y
git submodule update --init
wget -N https://github.com/AdoptOpenJDK/openjdk10-binaries/releases/download/jdk-10.0.2%2B13.1/OpenJDK10U-jdk_x64_linux_hotspot_10.0.2_13.tar.gz
tar -xf OpenJDK10U-jdk_x64_linux_hotspot_10.0.2_13.tar.gz
wget -N https://ci.adoptopenjdk.net/view/Dependencies/job/jtreg/lastSuccessfulBuild/artifact/jtreg-5.1-b01.tar.gz
tar -xf jtreg-5.1-b01.tar.gz
cd labs-openjdk-11
python build_labsjdk.py --configure-option=--disable-warnings-as-errors --boot-jdk=..//jdk-10.0.2+13/ \
--configure-option="--with-extra-cxxflags=-Ofast -march=native -mtune=native -funroll-loops -fomit-frame-pointer -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt -fopenmp -pthread -Wno-deprecated -Wno-errors" \
--configure-option="--with-extra-cflags=-Ofast -march=native -mtune=native -funroll-loops -fomit-frame-pointer -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt -fopenmp -pthread -Wno-deprecated -Wno-errors" \
--configure-option=--with-jvm-features=link-time-opt --configure-option=--enable-ccache --configure-option=--with-jtreg=..//jtreg/
./build/*/images/jdk/bin/java -version
make run-test-tier1