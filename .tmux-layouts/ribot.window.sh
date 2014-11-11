window_root "~/p/ribot"
new_window "ribot"

split_h 50
split_v 66

send_keys "" 0
send_keys "" 1
send_keys "" 2

run_cmd "svim" 0
run_cmd "cabal repl" 1
run_cmd ls 2

select_pane 0
