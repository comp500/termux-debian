# install necessary packages

apt install proot tar -y

# get the docker image

mkdir ~/debian
cd ~/debian
/data/data/com.termux/files/usr/bin/wget http://download.fedoraproject.org/pub/fedora/linux/releases/24/Docker/armhfp/images/Fedora-Docker-Base-24-1.2.armhfp.tar.xz

# extract the Docker image

/data/data/com.termux/files/usr/bin/tar xvf Fedora-Docker-Base-24-1.2.armhfp.tar.xz --strip-components=1 --exclude json --exclude VERSION

# extract the rootfs

/data/data/com.termux/files/usr/bin/tar xpf layer.tar

# cleanup

chmod +w .
rm layer.tar
rm Fedora-Docker-Base-24-1.2.armhfp.tar.xz

# fix DNS

echo "nameserver 8.8.8.8" > ~/debian/etc/resolv.conf

# make a shortcut

cat > /data/data/com.termux/files/usr/bin/debian <<- EOM
#!/data/data/com.termux/files/usr/bin/sh
proot -0 -r ~/fedora -b /dev/ -b /sys/ -b /proc/ -b $HOME /bin/env -i HOME=/root TERM="$TERM" PS1='[root@f24 \W]\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:/bin /bin/bash --login
EOM

chmod +x /data/data/com.termux/files/usr/bin/debian

# all done

echo "All done!, start Debian with 'debian'"
