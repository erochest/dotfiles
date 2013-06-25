# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/p/eb"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "eb"

# Split window into panes.
split_h 50
split_v 50

send_keys "" 0
send_keys "" 1
send_keys "" 2

run_cmd "vim -S project.vim" 0
run_cmd "ghci"               1
run_cmd "cat project.vim"    2

# Set active pane.
select_pane 0
