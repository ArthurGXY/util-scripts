command_exists() {
	command -v "$@" >/dev/null 2>&1
}

RESULT=1

if [[ -d /home/$USER/.oh-my-zsh ]]; then
	echo "Oh-my-zsh folder already exist. Skipping."
else
# oh my zsh
	sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
	RESULT=$?
fi

if [[ ! $RESULT -eq 0 ]]; then
    read -p "Oh-my-zsh install returned error code. Proceed? [y/N] " -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
	echo "User aborted."
        exit 1
    fi
    echo "Proceeding with plugins."
fi

# p10k
echo "Installing p10k theme..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# vscode plugin
echo "Installing vscode plugin..."
git clone https://github.com/valentinocossar/vscode.git $ZSH_CUSTOM/plugins/vscode

# zsh-syntax-highlighting
echo "Installing zsh-syntax-highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-autosuggestions
# configure acception key-binding:
# bindkey ',' autosuggest-accept
echo "Installing zsh-autosuggestions plugin..."
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# git-open
echo "Installing git-open plugin..."
git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open

