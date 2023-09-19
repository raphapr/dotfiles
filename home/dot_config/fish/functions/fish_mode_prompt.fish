function fish_mode_prompt
    if test "$fish_key_bindings" != fish_default_key_bindings
        set --local vi_mode_color
        set --local vi_mode_symbol
        switch $fish_bind_mode
            case default
                set vi_mode_color (set_color --bold black --background=89b4fa)
                set vi_mode_symbol N
            case insert
                set vi_mode_color (set_color --bold black --background a6e3a1 )
                set vi_mode_symbol I
            case replace replace_one
                set vi_mode_color (set_color $fish_color_match)
                set vi_mode_color (set_color --bold black --background fab387)
                set vi_mode_symbol R
            case visual
                set vi_mode_color (set_color --bold black --background f5c2e7)
                set vi_mode_symbol V
        end
        echo -e "$vi_mode_color $vi_mode_symbol \x1b[0m "
    end
end
