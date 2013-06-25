if initialize_session "general"; then
  new_window "main"
  split_h 50
  select_window 1
  select_pane 0
fi

# Finalize session creation and switch/attach to it.
finalize_and_go_to_session
