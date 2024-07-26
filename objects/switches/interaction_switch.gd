class_name SwitchComponent
extends Node

signal activation_signal(is_activated)

@export var is_activated:bool = false:
	get:
		return is_activated
	set(value):
		is_activated = value
		activation_signal.emit(value if not inversed_signal else !value)
		
@export var inversed_switch:bool = false # count as 1 when 0, and 0 when 1
@export var inversed_signal:bool = false # send 1 when switch to 0, and send 0 when switch to 1
#TODO: do we really need that distinction? might just simplify to one variable.

func on_interaction(requested:bool):
	pass
