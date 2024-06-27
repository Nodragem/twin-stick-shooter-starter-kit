extends Node3D
class_name LongInteractable

enum {OFF, PROGRESSING, REGRESSING, ON}
var state = OFF
var progress
@export_range(0,100) var progression_rate:float=10
@export_range(0,100) var regression_rate:float=10

func _process(delta):
	if state == PROGRESSING:
		progress += progression_rate*delta
	elif state == REGRESSING:
		progress -= regression_rate*delta

func on_interaction():
	if state == OFF or state == REGRESSING:
		state = PROGRESSING
		print("Progessing")
		$AnimationPlayer.play("switch_charging")

func on_interruption():
	if state == PROGRESSING:
		print("Regressing")
		state = REGRESSING
