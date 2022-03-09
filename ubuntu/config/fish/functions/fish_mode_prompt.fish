function fish_mode_prompt
    switch $fish_bind_mode
        case insert
            printf '\e[5 q'
        case replace_one
            printf '\e[3 q'
        case visual
            printf '\e[1 q'
        case default
            printf '\e[1 q'
        case "*"
            printf '\e[1 q'
    end
end
