if [ -z "${MY_APP_DIR}" ]; then
  echo "Set MY_APP_DIR in your environment"
  return 1
fi

GO_VERSION=1.19.4
BUILD_DIR="${MY_APP_DIR}/build/go/${GO_VERSION}"
GO_TAR=go${GO_VERSION}.linux-amd64.tar.gz
if [ ! -d "${BUILD_DIR}" ]; then
  mkdir --parents ${BUILD_DIR}
  cd ${BUILD_DIR}
  wget "https://go.dev/dl/${GO_TAR}"
fi

cd "${BUILD_DIR}"

INSTALL_DIR="${MY_APP_DIR}/install/go/${GO_VERSION}"
if [ -d "${INSTALL_DIR}" ]; then
  rm -rf "${INSTALL_DIR}"
fi
mkdir --parents "${INSTALL_DIR}"

tar -C "${INSTALL_DIR}" --strip-components=1 -xzf "${GO_TAR}"
