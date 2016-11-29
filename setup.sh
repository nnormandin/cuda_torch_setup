# my notes on getting CUA 8.0 / torch7 / LuaJIT to work on my Linux Mint desktop with GTX 760 GPU

# download the CUDA 8.0 and NVIDIA 375.20 driver run files
wget -O cuda https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_linux-run
wget -O driver http://us.download.nvidia.com/XFree86/Linux-x86_64/375.20/NVIDIA-Linux-x86_64-375.20.run

# purge anything related to NVIDIA or CUDA libraries
sudo apt-get purge nvidia*
sudo apt-get purge libcuda*

# edit blacklist.conf file
sudo nano /etc/modprobe.d/blacklist.conf

# add the followin to blacklist.conf:
blacklist amd76x_edac #this might not be required for x86 32 bit users.
blacklist vga16fb
blacklist nouveau
blacklist rivafb
blacklist nvidiafb
blacklist rivatv

# update to include nouveau blacklist
update-initramfs -u

# shutdown
sudo shutdown -r now

# stop X windows system on Mint 18
sudo service mdm stop

# install the driver
sudo sh ./driver

# install CUDA 8.0
sudo sh ./cuda

# restart again
sudo shutdown -r now

# export paths
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


# clone torch7 repo
git clone https://github.com/torch/distro.git ~/torch --recursive

# install torch, luaJIT, and dependencies
cd ~/torch; bash install-deps;
./install.sh

# source .bashrc to update
source ~/.bashrc

# run TREPL
th
