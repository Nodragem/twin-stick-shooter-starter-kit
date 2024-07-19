extends Switch
class_name ShortSwitch

func _ready():
	on_interaction(true)

func on_interaction(requested):
	if requested == false: 
		return
	
	is_activated = !is_activated
	if is_activated:
		print("interacting ON")
		$AnimationPlayer.play("on_state")
	else:
		print("interacting OFF")
		$AnimationPlayer.play("off_state")
