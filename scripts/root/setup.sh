# install required packages

dnf -y install podman git
sleep 10

# create the kiosk ignition user

useradd -p $(openssl passwd -1 password) ignition-kiosk-user

# add kiosk ignition user to sudoers

echo -e "ignition-kiosk-user\tALL=(ALL)\tNOPASSWD: ALL" > /etc/sudoers.d/020_ignition-kiosk-user

# enable autologin for the kiosk ignition user

cp /etc/gdm/custom.conf /etc/gdm/custom.conf.bak
cat <<EOF >/etc/gdm/custom.conf
# GDM configuration storage

[daemon]

# If true, the user given in AutomaticLogin should be logged in immediately. 
# This feature is like timed login with a delay of 0 seconds. 
AutomaticLoginEnable=true
# This is the user that should be logged in immediately if AutomaticLoginEnable is true.
AutomaticLogin=ignition-kiosk-user
EOF

# create startup routine for ignition-kios-user

mkdir -p /home/ignition-kiosk-user/.config/autostart
cat <<EOF >/home/ignition-kiosk-user/.config/autostart/ignition-kiosk-script.desktop
[Desktop Entry]
Type=Application
Exec=sh -c "xterm -hold -e /home/ignition-kiosk-user/ignition-rhel8-kiosk-setup/scripts/ignition-kiosk-user/autostart.sh"
Hidden=false
X-GNOME-Autostart-enabled=true
Name[en_US]=ignition-kiosk
name=ignition-kiosk
EOF

# clone repository

git clone https://github.com/keunlee/ignition-rhel8-kiosk-setup.git /home/ignition-kiosk-user/ignition-rhel8-kiosk-setup

# disable gnome-initial-setup

touch /home/ignition-kiosk-user/.config/gnome-initial-setup-done

# change file/dir owner to ignition-kiosk-user

chown -R ignition-kiosk-user /home/ignition-kiosk-user/ignition-rhel8-kiosk-setup
chown -R ignition-kiosk-user /home/ignition-kiosk-user/.config

