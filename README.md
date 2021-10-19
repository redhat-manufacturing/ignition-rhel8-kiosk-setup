# Overview: Ignition Kiosk Setup on RHEL 8

These scripts will update a RHEL 8 instance to automatically boot into another user account to automate the startup of a fullscreen kiosk into Inductive Automation Ignition

# Prerequisites

- RHEL 8 Workstation Installation

# Administrative Setup (Root Access Required)

1. Login in as root and clone the following repository: 

    `git clone https://github.com/redhat-manufacturing/ignition-rhel8-kiosk-setup.git`

2. Run the following script: 

    `sudo scripts/setup.sh`

    Once the script is ran successfully, there will be a new user added. 

    u/p: ignition-kiosk-user/password

3. Obtain an Ignition activation token and license key from [Inductive Automation](https://inductiveautomation.com/)  

- Copy the contents of the activation token to: `/home/ignition-kiosk-user/ignition-rhel8-kiosk-setup/scripts/ignition-kiosk-user/activation-token`
- Copy the contents of the license key to: `/home/ignition-kiosk-user/ignition-rhel8-kiosk-setup/scripts/ignition-kiosk-user/license-key`

4. Reboot the operating system. The Kiosk will start up automatically upon next boot into the Operating System
