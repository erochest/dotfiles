# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/p/soundscapes"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "soundscapes"

# Split window into panes.
split_h 50
split_v 66

send_keys "" 0
send_keys "" 1
send_keys "" 2

run_cmd "vim"                        0
run_cmd "warp -p 9010 -v"            1
run_cmd "open http://localhost:9010" 2

# Set active pane.
select_pane 0
