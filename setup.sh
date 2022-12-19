#!/usr/bin/env bash

# Creates links between all of these configuration settings and the user locations

CURRENT_OS=linux

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
NOW=`date +%s`

CONFIG_DIR="${HOME}/.config"

GLOBAL_GITIGNORE="${HOME}/.global.gitignore"
GIT_CONFIG="${HOME}/.gitconfig"

if [ -f "${GLOBAL_GITIGNORE}" ]; then
  mv "${GLOBAL_GITIGNORE}" "${GLOBAL_GITIGNORE}.bak${NOW}"
  echo "Global gitignore exists; backing up to ${GLOBAL_GITIGNORE}.bak${NOW}"
fi
ln -s "${SCRIPT_DIR}/.global.gitignore" "${GLOBAL_GITIGNORE}"
if [ -f "${GIT_CONFIG}" ]; then
  mv "${GIT_CONFIG}" "${GIT_CONFIG}.bak${NOW}"
fi
ln -s "${SCRIPT_DIR}/.gitconfig.${CURRENT_OS}" "${GIT_CONFIG}"

SOURCE_LINE="source ${SCRIPT_DIR}/common.env.sh"
ZSHRC_FILE="${HOME}/.zshrc"
SOURCES_SCRIPT=$(grep "# Source user Common config" "${ZSHRC_FILE}")
if [ -z "${SOURCES_SCRIPT}" ]; then
	echo "Adding source line to .zshrc"
	echo "# Source user Common config" >> "${ZSHRC_FILE}"
	echo "${SOURCE_LINE}" >> "${ZSHRC_FILE}"
fi

