extends Node3D
class_name Switch

signal switched(is_activated)

@export var is_activated:bool = false:
	get:
		return is_activated
	set(value):
		is_activated = value
		switched.emit(value)
		
@export var inversed_switch:bool = false


func on_interaction():
	pass

func on_interruption():
	pass
