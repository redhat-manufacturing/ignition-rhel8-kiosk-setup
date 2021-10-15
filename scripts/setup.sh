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

