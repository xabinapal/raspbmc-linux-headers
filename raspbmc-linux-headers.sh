# Stop graphical interface (reduces CPU load and saves RAM)
initctl stop xbmc

# Install basic packages for building
apt-get -y install build-essential gcc make

# Get Module.symvers from the Kernel headers
cd /tmp
wget http://raspbmc.com/downloads/bin/kernel/linux-headers-latest.deb.gz
mkdir linux-headers
dpkg-deb -x linux-headers-latest.deb.gz linux-headers
rm linux-headers-latest.deb.gz
mv linux-headers/usr/src/linux-headers-$(uname -r)/Module.symvers /usr/src
rm -R linux-headers

# Fetch and prepare the Kernel source
cd /usr/src
wget --no-check-certificate https://github.com/raspberrypi/linux/archive/rpi-$(uname -r | sed 's/[0-9]*$/y/').tar.gz
tar xzf rpi-*.tar.gz
rm rpi-*.tar.gz
mv linux-rpi-*y rpi-linux

# Configure the Kernel
cd /usr/src/rpi-linux
make mrproper
zcat /proc/config.gz > .config
sed -i 's/CONFIG_CROSS_COMPILE.*/CONFIG_CROSS_COMPILE=""/' .config
make modules_prepare
mv /usr/src/Module.symvers .

# Make symlinks
rm -r /lib/modules/$(uname -r)/build
ln -s /usr/src/rpi-linux /lib/modules/$(uname -r)/build