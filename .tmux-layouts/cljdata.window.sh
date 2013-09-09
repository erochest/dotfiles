# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "~/p/cljdata/sentiment/"

# Create new window. If no argument is given, window name will be based on
# layout file name.
new_window "cljdata"

# Split window into panes.
split_h 50
split_v 66
split_v 50

send_keys "" 0
send_keys "" 1
send_keys "" 2
send_keys "" 3

run_cmd "vim"          0
run_cmd "lein repl"    1
# run_cmd "lein spec -a" 2

# Set active pane.
select_pane 0
