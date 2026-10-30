# `atuin resume` typed at the prompt has no shell widget to receive the picked command, so
# with enter_accept = false it only prints it. Turn enter_accept on for that command only,
# leaving Ctrl-R unchanged. Event handlers instead of an `atuin` function: atuin's own hooks
# background `atuin ... &`, and fish can't background functions.
function _atuin_resume_preexec --on-event fish_preexec
    if string match -qr '^\s*atuin\s+(threads\s+)?resume\b' -- $argv[1]
        set -gx ATUIN_ENTER_ACCEPT true
    end
end

function _atuin_resume_postexec --on-event fish_postexec
    set -e ATUIN_ENTER_ACCEPT
end
