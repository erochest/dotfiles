# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/p/errsite"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "errsite"

# Split window into panes.
split_h 50
split_v 66

# Not sure why, but there's a form feed () on each prompt.
send_keys "" 0
send_keys "" 1
send_keys "" 2

run_cmd "vim"                                         0
run_cmd "./.cabal-sandbox/bin/site watch --port=9090" 1
run_cmd "open http://localhost:9090/"                 2

select_pane 0
