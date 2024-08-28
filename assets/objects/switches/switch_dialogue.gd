extends SwitchComponent


func on_interaction(requested):
	if get_parent().one_shot and is_activated:
		return
		
	if requested == false or Dialogic.current_timeline != null: 
		return
	is_activated = true

	Dialogic.start(get_parent().dialog_timeline,
					get_parent().jump_to_label)
	Dialogic.timeline_ended.connect(get_parent().on_timeline_ended)
	get_parent().dialog_started.emit()
	get_viewport().set_input_as_handled()
