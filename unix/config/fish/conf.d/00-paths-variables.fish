# Paths
# Homebrew
fish_add_path /opt/homebrew/bin

# deno (Javascript LSP)
fish_add_path $HOME/.deno/bin

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
