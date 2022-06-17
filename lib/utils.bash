#!/usr/bin/env bash

set -euo pipefail

K_REPO="https://download.konghq.com/mesh-alpine"
GH_REPO="https://github.com/kumahq/kuma"
TOOL_NAME="kumactl"
TOOL_TEST="kumactl help"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  sleep 3600
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//'
}

list_all_versions() {
  list_github_tags
}

get_platform() {
  local platform
  platform=$(uname)
  case $platform in
  Darwin) platform="darwin" ;;
  esac
  echo "$platform"
}

get_system_architecture() {
  local architecture
  architecture=$(uname -m)
  case $architecture in
  aarch64) architecture="arm64" ;;
  x86_64) architecture="amd64" ;;
  esac
  echo "$architecture"
}
download_release() {
  local version platform architecture filename url
  version="$1"
  platform="$(get_platform)"
  architecture="$(get_system_architecture)"
  filename="$2"

  # https://download.konghq.com/mesh-alpine/kuma-1.7.0-darwin-amd64.tar.gz

  url="$K_REPO/kuma-${version}-${platform}-${architecture}.tar.gz"

  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"


}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cp -r "$ASDF_DOWNLOAD_PATH"/"kuma-${version}/bin/"* "$install_path"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
