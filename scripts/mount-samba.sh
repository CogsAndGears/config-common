#!/usr/bin/env bash

# Basic instructions for mounting a samba share
# Run as root/sudo

SERVER_NAME=grandarchives
SERVER_IP=${SERVER_IP}
GROUP_NAME=smb-grandarchives
CREDENTIALS_NAME=grandarchives
SHARE_PATH=//grandarchives/GrandArchives
MOUNT_PATH=/mnt/grandarchives
SAMBA_USER=cogs
SAMBA_PASS=${PASSWORD}
LOCAL_USER=cogs

SERVER_EXISTS_IN_HOSTS=$(grep "${SERVER_NAME}" /etc/hosts)
if [ -z "${SERVER_EXISTS_IN_HOSTS}" ]; then
  echo "${SERVER_IP} ${SERVER_NAME}" >> /etc/hosts
fi

# create group to manage write access
if [ -z $(getent group "${GROUP_NAME}") ]; then
  groupadd ${GROUP_NAME}
fi
USER_IN_GROUP=$(grep "${GROUP_NAME}" <<< "$(groups ${LOCAL_USER})")
if [ -z "${USER_IN_GROUP}" ]; then
  usermod -a -G ${GROUP_NAME}
fi

# create credentials file for samba
if [ ! -d /etc/samba/credentials.d ]; then
  mkdir /etc/samba/credentials.d
fi
if [ ! -f "/etc/samba/credentials.d/${CREDENTIALS_NAME}" ]; then
  echo -e "username=${SAMBA_USER}\npassword=${SAMBA_PASS}" > "/etc/samba/credentials.d/${CREDENTIALS_NAME}"
fi

# mount the share
mount --mkdir -t cifs ${SHARE_PATH} ${MOUNT_PATH} -o gid=${GROUP_NAME},file_mode=0664,dir_mode=0775,credentials=/etc/samba/credentials.d/${CREDENTIALS_NAME}
