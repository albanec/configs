# установить terminator и запускать в нём!
sudo apt-get update
sudo apt-get remove -y gnome-mines gnome-sudoku sgt-puzzles gnome-software xfburn xfce4-notes orage parole \
libreoffice-* ristretto pidgin update-notifier numix-gtk-theme simple-scan xfce4-dict xfce4-weather-plugin \
xfce4-cpugraph-plugin xterm xfce4-terminal mousepad 
#
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64
#
sudo apt-get install -y keepassx terminator plank openvpn screenfetch curl numix-icon-theme p7zip-full p7zip-rar \
xubuntu-restricted-extras qemu-kvm libvirt-bin bridge-utils ppa-purge
#
mkdir ~/Templates/gear
wget -O- https://telegram.org/dl/desktop/linux | sudo tar xJ -C ~/Templates/gear
sudo ln -s ~/Templates/gear/Telegram/Telegram /usr/local/bin/telegram-desktop
#
wget https://download.truecrypt.ch/current/truecrypt-7.1a-linux-x64.tar.gz 
tar xvf truecrypt-7.1a-linux-x64.tar.gz
sudo ./truecrypt-7.1a-linux-x64
#
#
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
#
sudo apt-add-repository -y "deb https://download.sublimetext.com/ apt/stable/" && \
    sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge" && \
    sudo add-apt-repository -y "deb https://download.virtualbox.org/virtualbox/debian bionic contrib" && \
	sudo add-apt-repository -y ppa:numix/ppa    
	sudo add-apt-repository -y ppa:libreoffice/ppa
sudo apt-get update
#
sudo apt install -y sublime-text docker-ce virtualbox-5.2 numix-gtk-theme numix-icon-theme-circle \
	libreoffice-writer libreoffice-calc libreoffice-draw libreoffice-impress libreoffice-gtk libreoffice-style-elementary \
	pulseaudio-equalizer \
	fonts-firacode fonts-hack 
# sudo usermod -aG docker ${USER}
#
wget https://github.com/LinxGem33/Plank-Themes/archive/master.zip
7z x master.zip
sudo cp Plank-Themes-master/Plank\ Themes/* /usr/share/plank/themes/ -r
sudo chmod 755 /usr/share/plank/themes/* -R
rm Plank-Themes-master -r 
rm master.zip
#
sudo sh -c "echo 'vm.swappiness = 10\n\
net.ipv4.conf.all.accept_redirects = 0\n\
net.ipv6.conf.all.accept_redirects = 0\n\
net.ipv4.conf.all.secure_redirects = 0\n\
net.ipv4.conf.all.send_redirects = 0\n\
net.ipv4.tcp_fin_timeout = 10\n\
net.ipv4.tcp_orphan_retries = 0\n\
net.ipv4.tcp_syncookies = 1\n\
net.ipv4.tcp_timestamps = 0\n\
net.ipv4.conf.all.rp_filter = 1\n\
net.ipv4.conf.lo.rp_filter = 1\n\
net.ipv4.conf.wlp3s0.rp_filter = 1\n\
net.ipv4.conf.enp0s25.rp_filter = 1\n\
net.ipv4.conf.default.rp_filter = 1\n\
net.ipv4.conf.all.accept_source_route = 0\n\
net.ipv4.conf.lo.accept_source_route = 0\n\
net.ipv4.conf.wlp3s0.accept_source_route = 0\n\
net.ipv4.conf.enp0s25.accept_source_route = 0\n\
net.ipv4.conf.default.accept_source_route = 0\n\
net.ipv4.tcp_window_scaling = 1\n\
net.ipv4.icmp_echo_ignore_broadcasts = 1\n\
net.ipv4.icmp_ignore_bogus_error_responses = 1\n\
net.ipv4.tcp_max_syn_backlog = 1280\n\
kernel.core_uses_pid = 1\n\
net.bridge.bridge-nf-call-ip6tables=0\n\
net.bridge.bridge-nf-call-iptables=0\n\
net.bridge.bridge-nf-call-arptables=0\n\
net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
sudo sysctl -p
#
sudo ufw enable
#
sudo sh -c "echo '[connection]\n\
wifi.powersave = 2' > /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf"
echo "options iwlwifi 11n_disable=8" | sudo tee /etc/modprobe.d/iwlwifi11n.conf
#
sudo sh -c "echo 'default-sample-format = float32le\n\
default-sample-rate = 48000\n\
alternate-sample-rate = 44100\n\
default-sample-channels = 2\n\
default-channel-map = front-left,front-right\n\
default-fragments = 2\n\
default-fragment-size-msec = 125\n\
resample-method = soxr-vhq\n\
#resample-method = copy\n\
enable-lfe-remixing = no\n\
high-priority = yes\n\
nice-level = -11\n\
realtime-scheduling = yes\n\
realtime-priority = 9\n\
rlimit-rtprio = 9\n\
daemonize = no' >> /etc/pulse/daemon.conf"
sudo sh -c "echo 'defaults.pcm.minperiodtime 0\n\
defaults.pcm.rate_converter samplerate_best\n\
defaults.pcm.dmix.rate 44100' >> /usr/share/alsa/alsa.conf"
sudo sh -c "# Use PulseAudio plugin hw\n\
pcm.!default {\n\
   type plug\n\
   slave.pcm hw\n\
}' >> /etc/asound.conf"
