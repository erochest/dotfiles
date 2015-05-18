session_root "~/p/barth"

if initialize_session "barth"; then

  new_window "bash"
  run_cmd "source bin/activate"

  new_window "vim"
  run_cmd "source bin/activate"
  run_cmd "svim"

  new_window "ipython"
  run_cmd "source bin/activate"
  run_cmd "ipython"

  select_window 1

fi

finalize_and_go_to_session
