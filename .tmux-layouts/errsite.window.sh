# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/p/errsite"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "errsite"

# Split window into panes.
split_h 50
split_v 66
split_v 50

# Not sure why, but there's a form feed () on each prompt.
send_keys "" 0
send_keys "" 1
send_keys "" 2
send_keys "" 3

run_cmd "vim" 0
run_cmd "./dist/build/site/site watch" 1
run_cmd "warp -d _site"

select_pane 0
