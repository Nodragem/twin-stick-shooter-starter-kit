class_name CutSceneManager extends AnimationPlayer

var label_index = 1

func _ready():
	pass

func get_camera():
	return $Camera3D

func start_dialogue(name:String, label:String, disable_input:bool = false):
	Dialogic.start(name, label)
	if disable_input:
		Dialogic.Inputs._pause()
	
func go_to_next_sentence():
	Dialogic.handle_next_event()

func toggle_text_box():
	if Dialogic.Text.is_textbox_visible():
		Dialogic.Text.hide_textbox()
	else:
		Dialogic.Text.show_textbox()
