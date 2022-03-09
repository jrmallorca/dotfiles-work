###########
# GENERAL #
###########

# Set vi key bindings
fish_vi_key_bindings

# Removes fish greeting
set fish_greeting

# Replace cd with z
zoxide init fish | source

#############
# FUNCTIONS #
#############

function zf -d 'Go to last directory before quitting lf'
    set -l temp (mktemp) # Create a temporary file

    lf -last-dir-path "$temp" $argv # Put the last directory before quitting into temp
                                    # and listen for other flags

    if [ -f "$temp" ]             # Check if temp is a file
        set -l dest (cat "$temp") # Get destination from temp
        rm "$temp"                # Remove temp

        if [ -d "$dest" ]         # Check if destination is a directory
            z "$dest"             # Change directory to destination
        end
    end
end

function gd -d 'Git diff'
    set -l is_git (git rev-parse --git-dir 2>/dev/null) # Check if current directory is within a git directory

    # If it is a git directory, git diff selected files
    if [ -n "$is_git" ]
        cd (git rev-parse --show-toplevel)                   # Go to git root directory
        set -l preview git diff $argv --color=always -- {-1} # Set the preview command of fzf 
        git diff $argv --name-only |                         # Get git diffs
            fzf --multi --ansi --preview="$preview"          # Pipe diffs into fzf
    else
        echo "fatal: not a git repository (or any of the parent directories): .git"
    end
end

function gcl -d 'Clone a repository with using a username and repository name' -a username repository
    # Check if username and repository are non-empty then git clone
    if set -q username[1] repository[1]
        git clone git@github.com:$username/$repository.git
    else
        printf 'Missing either username or repository name'
    end
end

function gsetup -d 'Set up a new repository using a repository name'
    set repository (basename $PWD) # Assume repository name is the same in GitHub
    set username jrmallorca        # Set username in GitHub
    git init                       # Initialise repository
    git add -A                     # Add all changes in repository
    git commit -m "Initial commit" # Commit all changes
    git remote add origin \        # Link remote repository
        git@github.com:$username/$repository.git
    git push -u origin main        # Push all changes to remote repository
end

#################
# ABBREVIATIONS #
#################

# General
abbr xx 'chmod +x'

# Multihead
abbr xr 'xrandr --output "eDP1" --auto --output "HDMI-1-0" --auto --above "eDP1"'

# paru
abbr p 'paru -Syu'
abbr prm 'paru -Rs'

# (Un)mounting
abbr mntd 'sudo mount /dev/sda1 /mnt/d'
abbr umntd 'sudo umount /mnt/d'
abbr mntp 'simple-mtpfs --device 1 /mnt/phone/'
abbr umntp 'fusermount -u /mnt/phone/'

# Find files and directories

# Common directories

# Edit
abbr ef 'zf -command search_edit'
abbr er 'z / && zf -command search_edit'
abbr en 'z ~/neorg && zf -command search_edit'
abbr eh 'z ~/ && zf -command search_edit'
abbr ep 'z ~/Projects && zf -command search_edit'
abbr e. 'z $USERPROFILE/dotfiles-work/ubuntu/ && zf -command search_edit'
abbr ec 'z ~/.config && zf -command search_edit'
abbr edw 'z ~/Downloads && zf -command search_edit'
abbr eE 'z /etc && zf -command search_edit'
abbr eU 'z /usr && zf -command search_edit'
abbr emd 'z /mnt/d && zf -command search_edit'
abbr emdn 'z ~/mnt/d/Notes && zf -command search_edit'
abbr emdu 'z ~/mnt/d/University && zf -command search_edit'
abbr emp 'z /mnt/phone && zf -command search_edit'
abbr eg 'z (git rev-parse --show-toplevel) && zf -command search_edit'

# Navigate
abbr zr 'z / && zf'
abbr zh 'z ~/ && zf'
abbr zn 'z ~/neorg && zf'
abbr zp 'z ~/Projects && zf'
abbr z. 'z $USERPROFILE/dotfiles-work/ubuntu/ && zf'
abbr zc 'z ~/.config && zf'
abbr zdw 'z ~/Downloads && zf'
abbr zE 'z /etc && zf'
abbr zU 'z /usr && zf'
abbr zmd 'z /mnt/d && zf'
abbr zmdn 'z ~/mnt/d/Notes && zf'
abbr zmdu 'z ~/mnt/d/University && zf'
abbr zmp 'z /mnt/phone && zf'
abbr zg 'z (git rev-parse --show-toplevel) && zf'

# TMUX
abbr t 'tmux'
abbr tls 'tmux ls'
abbr tn 'tmux new -s'
abbr ta 'tmux attach-session'
abbr tat 'tmux attach-session -t'
abbr tk 'tmux kill-session'
abbr rmtr 'rm -rf ~/.tmux/resurrect/*'

# Java versions
abbr j11 'sudo archlinux-java set java-11-openjdk'
abbr j17 'sudo archlinux-java set java-17-openjdk'

# Chat
abbr we 'weechat'
abbr wh 'whatscli'
abbr s 'scli'

# Editor
abbr se 'sudoedit'
abbr e 'nvim'

# Dotfiles
abbr mc 'z $USERPROFILE/dotfiles-work/ubuntu/ && make configuration && prevd'

# nmcli
abbr ns 'nmcli c show'
abbr nd 'nmcli c down'
abbr nu 'nmcli c up'
abbr nc 'nmcli -a d wifi connect'

# Git
abbr ga 'git ls-files --modified --others --exclude-standard --deduplicate | fzf --ansi --multi --print0 --preview="git diff --color=always -- {-1} | diff-so-fancy" | xargs --null --open-tty git add'
abbr ga. 'git add .'
abbr gaa 'git add -A'
abbr gb 'git branch'
abbr gbl 'git blame'
abbr gc 'git commit -S -m'
abbr gca 'git commit --amend -S -m'
abbr gco 'git branch | fzf --ansi | xargs git checkout'
abbr gcoc 'git log --oneline | fzf --ansi | head -n1 | awk \'{print $1;}\' | xargs git checkout'
abbr gcob 'git checkout -b'
abbr gcp 'git cherry-pick'
abbr gd 'git diff --name-only | fzf --multi --ansi --preview="git diff --color=always -- {-1} | diff-so-fancy"'
abbr gdc 'git diff --cached --name-only | fzf --multi --ansi --preview="git diff --cached --color=always -- {-1} | diff-so-fancy"'
abbr gf 'git fetch'
abbr gl 'git log'
abbr gm 'git merge'
abbr gp 'git push'
abbr gpf 'git push --force-with-lease'
abbr gpl 'git pull'
abbr gplrom 'git pull --rebase origin main'
abbr gr 'git remote'
abbr grop 'git remote prune origin --dry-run'
abbr grb 'git rebase'
abbr gs 'git status'
abbr gst 'git stash'
abbr gg 'git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
abbr gresign 'git rebase --exec \'git commit --amend --no-edit -n -S\' -i'

# GitHub CLI
abbr ghi 'gh issue'
abbr ghic 'gh issue create --assignee @me'
abbr ghil 'gh issue list'
abbr ghpr 'gh pr'
abbr ghprc 'gh pr create --assignee @me --base'

set -x GPG_TTY (tty)

########
# PATH #
########

# Windows variable
set -gx USERPROFILE (wslpath (wslvar USERPROFILE))

# Editor variable
set -gx EDITOR /usr/bin/nvim

# Zoxide variables
set -gx _ZO_ECHO '1'
set -gx _ZO_DATA_DIR $HOME/.local/share

# deno (Javascript LSP)
fish_add_path /home/joni/.deno/bin

# Cargo
fish_add_path RUST_SRC_PATH $HOME/.cargo/bin

# Flutter
# fish_add_path /usr/lib/dart/bin
# set -gx JAVA_OPTS '-XX:+IgnoreUnrecognizedVMOptions'
# set -gx ANDROID_SDK_ROOT /opt/android-sdk
