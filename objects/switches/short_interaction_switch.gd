class_name ShortSwitch
extends SwitchComponent

func on_interaction(requested):
	is_activated = true


func _on_body_entered(body):
	if body is PlayerEntity:
		on_interaction(true)
