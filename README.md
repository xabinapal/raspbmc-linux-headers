raspbmc-linux-headers
=====================

Kernel headers are not included in Raspbmc by default. This script will download and install them, and will also fetch Module.symvers so you dont have to generate it with `make modules`. Just `./raspbmc-linux-headers.sh` and it will do its magic, assuming you have the latest Raspbmc version.
