if not set -q MY_ABBR_SET
    set -U MY_ABBR_SET true

    # General
    abbr xx 'chmod +x'

    # Multihead
    if [ "$OSTYPE" = "Linux" ]
        abbr xr 'xrandr --output "eDP1" --auto --output "HDMI-1-0" --auto --above "eDP1"'
    end

    # Package manager
    if [ "$OSTYPE" = "Linux" ]
        if type -q paru
            abbr p 'paru -Syu'
            abbr prm 'paru -Rs'
        else if type -q apt
            abbr p 'sudo apt update && sudo apt upgrade && sudo apt install'
            abbr prm 'sudo apt autoremove && sudo apt remove'
        end
    else if [ "$OSTYPE" = "MacOS" ]
        abbr p 'brew upgrade && brew install'
        abbr prm 'brew uninstall'
    end

    # (Un)mounting
    abbr mntc 'sudo mount /dev/sda1 /mnt/c'
    abbr umntc 'sudo umount /mnt/c'
    abbr mntp 'simple-mtpfs --device 1 /mnt/phone/'
    abbr umntp 'fusermount -u /mnt/phone/'

    # Find files and directories

    # Common directories

    # Edit
    abbr ef 'zf -command search_edit'
    abbr er 'z / && zf -command search_edit'
    abbr en 'z ~/neorg && zf -command search_edit'
    abbr eh 'z ~/ && zf -command search_edit'
    abbr ec 'z ~/.config && zf -command search_edit'
    abbr edw 'z ~/Downloads && zf -command search_edit'
    abbr eE 'z /etc && zf -command search_edit'
    abbr eU 'z /usr && zf -command search_edit'
    abbr emc 'z /mnt/c && zf -command search_edit'
    abbr emph 'z /mnt/phone && zf -command search_edit'
    abbr eg 'z (git rev-parse --show-toplevel) && zf -command search_edit'

    if [ "$OSTYPE" = "WSL" ]
        abbr e. 'z $USERPROFILE/dotfiles-work && zf -command search_edit'
        abbr ep 'z $USERPROFILE/projects && zf -command search_edit'
    else
        abbr e. 'z ~/dotfiles-work && zf -command search_edit'
        abbr ep 'z ~/projects && zf -command search_edit'
    end

    # Navigate
    abbr zr 'z / && zf'
    abbr zn 'z ~/neorg && zf'
    abbr zc 'z ~/.config && zf'
    abbr zdw 'z ~/Downloads && zf'
    abbr zE 'z /etc && zf'
    abbr zU 'z /usr && zf'
    abbr zmc 'z /mnt/c && zf'
    abbr zg 'z (git rev-parse --show-toplevel) && zf'

    if [ "$OSTYPE" = "WSL" ]
        abbr z. 'z $USERPROFILE/dotfiles-work && zf'
        abbr zh 'z $USERPROFILE && zf'
        abbr zp 'z $USERPROFILE/projects && zf'
        abbr zDw 'z $USERPROFILE/Downloads && zf'
    else
        abbr z. 'z ~/dotfiles-work && zf'
        abbr zh 'z ~/ && zf'
        abbr zp 'z ~/projects && zf'
    end

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

    # nmcli
    abbr ns 'nmcli c show'
    abbr nd 'nmcli c down'
    abbr nu 'nmcli c up'
    abbr nc 'nmcli -a d wifi connect'

    # Git
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

    if [ "$OSTYPE" = "MacOS" ]
        abbr ga 'git ls-files --modified --others --exclude-standard --deduplicate | fzf --ansi --multi --print0 --preview="git diff --color=always -- {-1} | diff-so-fancy" | xargs -0 -o git add'
    else
        abbr ga 'git ls-files --modified --others --exclude-standard --deduplicate | fzf --ansi --multi --print0 --preview="git diff --color=always -- {-1} | diff-so-fancy" | xargs --null --open-tty git add'
    end

    # GitHub CLI
    abbr ghi 'gh issue'
    abbr ghic 'gh issue create --assignee @me'
    abbr ghil 'gh issue list'
    abbr ghpr 'gh pr'
    abbr ghprc 'gh pr create --assignee @me --base'
end
