extends Node3D
class_name LongInteractable

var is_activated = false

func on_interaction():
	is_activated = !is_activated
	if is_activated:
		print("interacting ON")
		$AnimationPlayer.play("progession_bar")
		#$AnimationPlayer.seek(0.5, true)
	else:
		print("interacting OFF")
		$AnimationPlayer.play_backwards("progession_bar")
		#$AnimationPlayer.seek(0.0, true)
