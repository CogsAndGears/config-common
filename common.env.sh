if [ -z "${MY_APP_DIR}" ]; then
  echo "Set MY_APP_DIR in your environment"
  return 1
fi

# Add go
GO_VERSION=1.21.4
GO_DIR="${MY_APP_DIR}/install/go/${GO_VERSION}"

export PATH=${GO_DIR}/bin:${PATH}

alias dc=docker-compose

# Kitty has some terminal issues while SSHing; this kitten attempts to resolve that automatically
# and copies over some terminfo to the remote host
# See: https://wiki.archlinux.org/title/Kitty#Terminal_issues_with_SSH
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Add Android SDK to path
export PATH=$PATH:${MY_APP_DIR}/install/android-studio/bin
alias android-studio="pushd ${MY_APP_DIR}/install/android-studio/bin && ./studio.sh && popd"
alias adb="~/Android/Sdk/platform-tools/adb"
