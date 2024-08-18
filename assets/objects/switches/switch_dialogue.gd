extends SwitchComponent

func on_interaction(requested):
	if requested == false or Dialogic.current_timeline != null: 
		return
	is_activated = true

	Dialogic.start('dr_megadroon')
	get_viewport().set_input_as_handled()
