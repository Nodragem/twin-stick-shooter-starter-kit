extends Node3D
class_name LongInteractable

enum {OFF, PROGRESSING, REGRESSING, ON}
var state = OFF
var progress: float = 0
@export_range(0,100) var progression_rate:float=10
@export_range(0,100) var regression_rate:float=10
@onready var anim_tree: AnimationTree = $AnimationTree

func _process(delta):
	if state == PROGRESSING:
		progress = min(100, progress + progression_rate*delta)
	elif state == REGRESSING:
		progress = min(0, progress - regression_rate*delta)
	anim_tree["parameters/time_seek/seek_request"] = progress/100.0
	
func on_interaction():
	if state == OFF or state == REGRESSING:
		state = PROGRESSING
		print("Progressing")
		$AnimationPlayer.play("switch_charging")

func on_interruption():
	if state == PROGRESSING:
		print("Regressing")
		state = REGRESSING
