# Set vi key bindings
fish_vi_key_bindings

# Removes fish greeting
set fish_greeting

# Replace cd with z
zoxide init fish | source

set -x GPG_TTY (tty)

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
