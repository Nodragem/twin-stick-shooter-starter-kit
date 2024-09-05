extends Resource
class_name GameDataStore


signal controller_scheme_changed
@export_range(0,3) var controller_scheme: int:
	get:
		return controller_scheme
	set(value):
		controller_scheme_changed.emit(value)
		controller_scheme = value

func _init(p_controller_scheme = 0):
	controller_scheme = p_controller_scheme
