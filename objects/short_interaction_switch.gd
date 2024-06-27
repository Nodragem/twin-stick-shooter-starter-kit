extends Node3D
class_name ShortInteractable

var is_activated = false

func on_interaction():
	is_activated = !is_activated
	if is_activated:
		print("interacting ON")
		$AnimationPlayer.play("on_state")
	else:
		print("interacting OFF")
		$AnimationPlayer.play("off_state")
