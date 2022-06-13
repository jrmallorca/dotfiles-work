# ----------------------------------------------------------------------------
# MacOS Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
configuration:
	cp -a ./../config/. ~/.config/

# -----------------------------------------------------------------------------
# Programs
# -----------------------------------------------------------------------------

# Base
# -----------------------------------------------------------------------------
# Install main programs.
necessary:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew upgrade
	brew install wget fzf fd bat ripgrep \
		neovim fish zoxide diff-so-fancy lf gh
	chsh -s /usr/bin/fish
	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	git config --global interactive.diffFilter "diff-so-fancy --patch"

fisher: SHELL:=/usr/bin/fish
fisher:
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

fisherplugins: SHELL:=/usr/bin/fish
fisherplugins:
	fisher install jorgebucaran/nvm.fish
