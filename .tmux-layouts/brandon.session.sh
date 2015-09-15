session_root "~/p/woolf"

if initialize_session "brandon"; then

  new_window "bash"
  run_cmd "source bin/activate"

  new_window "ipython"
  run_cmd "source bin/activate"
  run_cmd "ipython"

  new_window "vim"
  run_cmd "source bin/activate"
  run_cmd "svim"

  select_window 1

fi

finalize_and_go_to_session
