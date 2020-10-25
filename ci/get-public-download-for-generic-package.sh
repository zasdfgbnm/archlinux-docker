#!/bin/sh

set -eu

package_name=$1

package_id=$(curl --header "PRIVATE-TOKEN: ${GITLAB_PROJECT_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/packages" | jq ".[] | select(.version == \"${BUILD_VERSION}\") | .id")
base_id=$(curl --header "PRIVATE-TOKEN: ${GITLAB_PROJECT_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/packages/${package_id}/package_files" | jq ".[] | select(.file_name == \"$package_name\") | .id")
echo "https://gitlab.archlinux.org/archlinux/archlinux-docker/-/package_files/${base_id}/download"
