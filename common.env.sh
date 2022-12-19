if [ -z "${MY_APP_DIR}" ]; then
  echo "Set MY_APP_DIR in your environment"
  return 1
fi

# Add go
GO_VERSION=1.19.4
GO_DIR="${MY_APP_DIR}/install/go/${GO_VERSION}"

export PATH=${GO_DIR}/bin:${PATH}
