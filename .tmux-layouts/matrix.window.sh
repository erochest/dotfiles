window_root "~/p/matrix"

new_window "matrix"

split_h 50
split_v 50

send_keys "" 0
send_keys "" 1
send_keys "" 2

run_cmd "vim"     0
run_cmd "bpython" 1
run_cmd "ls"      2

select_pane 0
