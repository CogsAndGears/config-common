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
export PATH=$PATH:${MY_APP_DIR}/install/android-studio/installed/bin
alias android-studio=studio.sh
alias adb="~/Android/Sdk/platform-tools/adb"

# Add obsidian to path
export PATH=$PATH:${MY_APP_DIR}/install/obsidian/installed

# Add texlive to path
export PATH=$PATH:/srv/app/install/texlive/2024/bin/x86_64-linux
export INFOPATH=$INFOPATH:/srv/app/install/texlive/2024/texmf-dist/doc/info
export MANPATH=$MANPATH:/srv/app/install/texlive/2024/texmf-dist/doc/man
