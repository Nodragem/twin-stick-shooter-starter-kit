# Common to ALL Controllers
extends PlayerState
class_name DeadState

@export var is_taking_input:bool = false

func _ready():
	super._ready()

func unhandled_input(event: InputEvent) -> void:
	if not is_taking_input:
		return
	if event.is_action_pressed("p1_pause"):
		print("Respawn Requested!")
