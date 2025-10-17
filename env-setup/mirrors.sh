#!/usr/bin/env bash

function sep() {
    echo "---------- $1 ----------"
}

# Arch specific
sep "Arch Specific (Manual)"
echo 'Put this on top of mirrors in /etc/pacman.d/mirrorlist:'
echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch'


# Python
sep "Python"

# pip
pip config set global.index-url https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
pip config set global.extra-index-url "https://mirrors.ustc.edu.cn/pypi/simple "

# uv
cat << EOF | tee -a ~/.config/uv/uv.toml
[[index]]
url = "https://mirrors.ustc.edu.cn/pypi/simple"
default = true
EOF

# Rust 
sep "Rust Lang"

# Rust Crates.io
mkdir -vp ${CARGO_HOME:-$HOME/.cargo}

cat << EOF | tee -a ${CARGO_HOME:-$HOME/.cargo}/config.toml
[source.crates-io]
replace-with = 'tuna'

[source.tuna]
registry = "sparse+https://mirrors.tuna.tsinghua.edu.cn/crates.io-index/"

[registries.tuna]
index = "sparse+https://mirrors.tuna.tsinghua.edu.cn/crates.io-index/"

[source.ustc]
registry = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"

[registries.ustc]
index = "sparse+https://mirrors.ustc.edu.cn/crates.io-index/"
EOF

# Rustup (fish)
echo 'set -x RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup' >> ~/.config/fish/config.fish
echo 'set -x RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup' >> ~/.config/fish/config.fish
