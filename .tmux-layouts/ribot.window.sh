window_root "~/p/ribot"
new_window "ribot"

split_h 50
split_v 66
split_v 50

send_keys "" 0
send_keys "" 1
send_keys "" 2
send_keys "" 3

run_cmd "vim" 0
run_cmd "guard" 1
run_cmd "cabal repl" 2
run_cmd ls 3

select_pane 0
