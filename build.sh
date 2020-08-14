sudo apt-get install aptitude
sudo aptitude install build-essential libcups2-dev openjdk-14-jdk libx11-dev libxext-dev libxrender-dev libxrandr-dev libxtst-dev libxt-dev libasound2-dev autoconf
git submodule update --init
cd jdk15
bash configure --with-jvm-variants=server --with-jvm-features=link-time-opt \
--with-extra-cflags='-Ofast -march=native -mtune=broadwell -funroll-loops -fomit-frame-pointer -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt -fopenmp -pthread -Wno-error -w' \
--with-extra-cxxflags='-Ofast -march=native -mtune=broadwell -funroll-loops -fomit-frame-pointer -pipe -fstack-protector-strong --param=ssp-buffer-size=4 -fno-plt -fopenmp -pthread -Wno-error -w'
make images
./build/*/images/jdk/bin/java -version
make run-test-tier1