extends Node
class_name Switch

signal activation_signal(is_activated)

@export var is_activated:bool = false:
	get:
		return is_activated
	set(value):
		is_activated = value
		activation_signal.emit(value)
		
@export var inversed_switch:bool = false


func on_interaction(requested:bool):
	pass
