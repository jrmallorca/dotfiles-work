# ----------------------------------------------------------------------------
# Ubuntu Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
configuration:
	cp -a config/. ~/.config/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Base
# -----------------------------------------------------------------------------
# Install main programs.
necessary:
	sudo apt-add-repository ppa:fish-shell/release-3
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt update -y && sudo apt upgrade -y
	sudo apt install -y git neovim fish zathura curl wget fzf fd-find bat ripgrep \
		cargo xdg-user-dirs
	chsh -s /usr/bin/fish

zoxide:
	curl -sS https://webinstall.dev/zoxide | bash

lf:
	wget https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz \
-O lf-linux-amd64.tar.gz
	tar xvf lf-linux-amd64.tar.gz
	chmod +x lf
	sudo mv lf /usr/local/bin
	rm -rf lf-linux-amd64.tar.gz

fisher:
	curl -sL https://git.io/fisher | . && fisher install jorgebucaran/fisher

fisherplugins:
	fisher install PatrickF1/fzf.fish
