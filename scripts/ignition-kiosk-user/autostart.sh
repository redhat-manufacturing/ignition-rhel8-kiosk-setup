# start podman
IGNITION_LICENSE_KEY=$(</home/ignition-kiosk-user/ignition-rhel8-kiosk-setup/scripts/ignition-kiosk-user/license-key)
IGNITION_ACTIVATION_TOKEN_FILE_PATH=/home/ignition-kiosk-user/ignition-rhel8-kiosk-setup/scripts/ignition-kiosk-user/activation-token
IGNITION_CLIENT_URL=http://localhost:8088/data/perspective/client/samplequickstart

CONTAINER_EXISTS=$(podman container exists my-ignition-maker; echo $?)

if [[ CONTAINER_EXISTS -eq 0 ]]
then
    podman start my-ignition-maker
    sleep 15
    firefox -kiosk $IGNITION_CLIENT_URL
else
    podman run -p 8088:8088 --name my-ignition-maker --privileged \
    -e GATEWAY_ADMIN_PASSWORD=password \
    -e IGNITION_EDITION=maker \
    -e IGNITION_LICENSE_KEY=$IGNITION_LICENSE_KEY \
    -v $IGNITION_ACTIVATION_TOKEN_FILE_PATH:/activation-token \
    -e IGNITION_ACTIVATION_TOKEN_FILE=/activation-token \
    -d quay.io/kelee/ignition-maker-ubi:8.1.10
fi