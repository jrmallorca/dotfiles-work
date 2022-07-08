# Variables
# OS Type
switch (uname)
    case Linux
        set -gx OSTYPE "Linux"
    case Darwin
        set -gx OSTYPE "MacOS"
    case '*'
        if [ type -q wslpath ]
            set -gx OSTYPE "WSL"
        else
            set -gx OSTYPE "unknown"
        end
end

# GPG
set -x GPG_TTY (tty)

# Windows
if [ "$OSTYPE" = "WSL" ]
    set -gx USERPROFILE (wslpath (wslvar USERPROFILE))
end

# Editor
if [ "$OSTYPE" = "MacOS" ]
    set -gx EDITOR /opt/homebrew/bin/nvim
else
    set -gx EDITOR /usr/bin/nvim
end

# Zoxide
set -gx _ZO_ECHO '1'
set -gx _ZO_DATA_DIR $HOME/.local/share

# Cargo
if [ "$OSTYPE" = "WSL" ]
    fish_add_path RUST_SRC_PATH $HOME/.cargo/bin
end

# nvm.fish
set -x nvm_default_version lts

# Paths
# Homebrew
if [ "$OSTYPE" = "MacOS" ]
    fish_add_path /opt/homebrew/bin
end

