# ----------------------------------------------------------------------------
# MacOS Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
configuration:
	cp -a ./../config/. ~/.config/
	cp -a ./config/. ~/.config/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Base
# -----------------------------------------------------------------------------
# Install main programs.
necessary: SHELL:=/bin/bash
necessary:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
	brew install wget fzf fd bat ripgrep jq \
		neovim fish zoxide diff-so-fancy lf gh
	brew tap homebrew/cask-fonts
	brew install --cask font-iosevka-ss14
	echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
	chsh -s /opt/homebrew/bin/fish
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"

fisher: SHELL:=/usr/bin/fish
fisher:
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisherplugins: SHELL:=/usr/bin/fish
fisherplugins:
	fisher install jorgebucaran/nvm.fish
