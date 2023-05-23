function fish_prompt --description Hydro
    set -g hydro_color_git 99ff99
    set -l _aws_profile ""

    if set -q AWS_PROFILE
        set _aws_profile (set_color f9e2af)"  $AWS_PROFILE "(set_color normal)
    end

    set -l _extra_status "$_aws_profile"

    echo -e "$_hydro_color_pwd$_hydro_pwd$hydro_color_normal $_hydro_color_git$$_hydro_git$hydro_color_normal$_hydro_color_duration$_hydro_cmd_duration$hydro_color_normal$_extra_status$_hydro_status$hydro_color_normal "
end
