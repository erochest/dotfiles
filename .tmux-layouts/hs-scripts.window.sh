# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/p/hs-scripts"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "hs-scripts"

# Split window into panes.
split_h 50
split_v 50

send_keys "" 0
send_keys "" 1
send_keys "" 2

run_cmd "svim"  0
run_cmd "ghci" 1
run_cmd "ls"   2

# Set active pane.
select_pane 0
