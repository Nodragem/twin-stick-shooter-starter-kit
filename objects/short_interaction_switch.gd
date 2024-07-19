extends Switch
class_name ShortSwitch

func _ready():
	update_animation()

func on_interaction(requested):
	if requested == false: 
		return
	is_activated = !is_activated
	update_animation()


func update_animation():
	if is_activated:
		print("interacting ON")
		$AnimationPlayer.play("on_state")
	else:
		print("interacting OFF")
		$AnimationPlayer.play("off_state")
