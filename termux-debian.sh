# install necessary packages

apt install proot tar -y

# get the docker image

# old image is https://github.com/tianon/docker-brew-debian/raw/5f84ff77365de2ee50655978edad2ba5004c1321/stable/rootfs.tar.xz

mkdir ~/debian
cd ~/debian
/data/data/com.termux/files/usr/bin/wget https://partner-images.canonical.com/core/yakkety/current/ubuntu-yakkety-core-cloudimg-armhf-root.tar.gz

# extract the rootfs

/data/data/com.termux/files/usr/bin/tar xvf ubuntu-yakkety-core-cloudimg-armhf-root.tar.xz

# cleanup

chmod +w .
rm rootfs.tar.xz

# fix DNS

echo "nameserver 8.8.8.8" > ~/debian/etc/resolv.conf

# make a shortcut

cat > /data/data/com.termux/files/usr/bin/debian <<- EOM
#!/data/data/com.termux/files/usr/bin/sh
proot -0 -r ~/debian -b /dev/ -b /sys/ -b /proc/ -b $HOME /usr/bin/env -i HOME=/root TERM="$TERM" PS1='[root@deb \W]\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin:/bin /bin/bash --login
EOM

chmod +x /data/data/com.termux/files/usr/bin/debian

# all done

echo "All done!, start Debian with 'debian'"
