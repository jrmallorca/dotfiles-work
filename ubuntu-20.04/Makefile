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
	sudo add-apt-repository ppa:git-core/ppa
	sudo add-apt-repository ppa:aos1/diff-so-fancy
	sudo apt update -y && sudo apt upgrade -y
	sudo apt install -y git neovim fish zathura curl wget fzf fd-find \
		cargo xdg-user-dirs \
		cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 \
		diff-so-fancy
	sudo apt install -o Dpkg::Options::="--force-overwrite" bat ripgrep
	cargo install zoxide --locked
	cargo install alacritty
	chsh -s /usr/bin/fish

packer:
	git clone --depth 1 https://github.com/wbthomason/packer.nvim \
		~/.local/share/nvim/site/pack/packer/start/packer.nvim


diff-so-fancy:
	sudo add-apt-repository ppa:aos1/diff-so-fancy
	sudo apt update -y
	sudo apt install -y diff-so-fancy
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"

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
