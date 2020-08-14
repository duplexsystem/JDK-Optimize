sudo apt-get install aptitude -y
sudo aptitude install build-essential libcups2-dev openjdk-14-jdk libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev libasound2-dev libfontconfig1-dev autoconf -y
git submodule update --init
cd jdk15
wget https://ci.adoptopenjdk.net/view/Dependencies/job/jtreg/lastSuccessfulBuild/artifact/jtreg-5.1-b01.tar.gz
tar -xf jtreg-5.1-b01.tar.gz
bash configure --with-jvm-variants=server --with-jvm-features=link-time-opt --enable-ccache --with-jtreg=./jtreg/ \
--with-extra-cflags='-Ofast -march=native -mtune=native -funroll-loops -fomit-frame-pointer -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt -fopenmp -pthread -w' \
--with-extra-cxxflags='-Ofast -march=native -mtune=native -funroll-loops -fomit-frame-pointer -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt -fopenmp -pthread -w'
make clean
make images
./build/*/images/jdk/bin/java -version
make run-test-tier1