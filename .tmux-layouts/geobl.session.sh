session_root "~/p/geobl"

if initialize_session "geobl"; then
  new_window "bash"
  run_cmd "vagrant up"

  new_window "vagrant"

  new_window "geobl"
  run_cmd "cd geoblacklight"

  select_window 1
fi

finalize_and_go_to_session
