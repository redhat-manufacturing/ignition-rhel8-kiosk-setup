# start podman
IGNITION_LICENSE_KEY=$(</home/ignition-kiosk-user/ignition-rhel8-kiosk-setup/scripts/ignition-kiosk-user/license-key)
IGNITION_ACTIVATION_TOKEN_FILE_PATH=/home/ignition-kiosk-user/ignition-rhel8-kiosk-setup/scripts/ignition-kiosk-user/activation-token

podman run -p 8088:8088 --name my-ignition-maker --privileged \
-e GATEWAY_ADMIN_PASSWORD=password \
-e IGNITION_EDITION=maker \
-e IGNITION_LICENSE_KEY=$IGNITION_LICENSE_KEY \
-v $IGNITION_ACTIVATION_TOKEN_FILE_PATH:/activation-token \
-e IGNITION_ACTIVATION_TOKEN_FILE=/activation-token \
-d quay.io/kelee/ignition-maker-ubi:8.1.10
