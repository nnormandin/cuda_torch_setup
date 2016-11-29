# Notes on getting CUDA 8.0 / torch7 / LuaJIT to work on my Linux Mint desktop with GTX 760 GPU

Download the CUDA 8.0 and NVIDIA 375.20 driver run files
```bash
wget -O cuda https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_linux-run
wget -O driver http://us.download.nvidia.com/XFree86/Linux-x86_64/375.20/NVIDIA-Linux-x86_64-375.20.run
```

Purge anything related to NVIDIA or CUDA libraries
```bash
sudo apt-get purge nvidia*
sudo apt-get purge libcuda*
```

Edit blacklist.conf file
```bash
sudo nano /etc/modprobe.d/blacklist.conf
```

Add the following to blacklist.conf:
```bash
blacklist amd76x_edac #this might not be required for x86 32 bit users.
blacklist vga16fb
blacklist nouveau
blacklist rivafb
blacklist nvidiafb
blacklist rivatv
```

Update to include nouveau blacklist
```bash
update-initramfs -u
```

Restart
```bash
sudo shutdown -r now
```

Stop X windows system on Mint 18
```bash
sudo service mdm stop
```

Install the driver
```bash
sudo sh ./driver
```

Install CUDA 8.0
```bash
sudo sh ./cuda
```

Restart again
```bash
sudo shutdown -r now
```

Export paths
```bash
export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```


Clone torch7 repo
```bash
git clone https://github.com/torch/distro.git ~/torch --recursive
```

Install torch, luaJIT, and dependencies
```bash
cd ~/torch; bash install-deps;
./install.sh
```

Source .bashrc to update
```bash
source ~/.bashrc
```

Run TREPL
```bash
th
```
