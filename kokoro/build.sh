#!/bin/bash
set -eux
set -o pipefail

go version

if [[ -v KOKORO_GIT_COMMIT ]] && [[ -d git/repo ]]; then
  cd git/repo
elif [[ -v KOKORO_GIT_COMMIT ]] && [[ -d github/repo ]]; then
  cd github/repo
fi

make bin/gvisor-containerd-shim
artifact_dir="$(date -u --rfc-3339=date)"
mkdir "$artifact_dir"
mv bin/gvisor-containerd-shim "${artifact_dir}/gvisor-containerd-shim"
