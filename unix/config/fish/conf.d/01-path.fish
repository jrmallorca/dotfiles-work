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

# deno (Javascript LSP)
fish_add_path $HOME/.deno/bin

# Cargo
if [ "$OSTYPE" = "WSL" ]
    fish_add_path RUST_SRC_PATH $HOME/.cargo/bin
end
