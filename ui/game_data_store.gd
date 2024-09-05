extends Resource
class_name GameDataStore


signal controller_scheme_changed
@export_range(0,3) var controller_scheme: int:
	get:
		return controller_scheme
	set(value):
		controller_scheme_changed.emit(value)
		controller_scheme = value
		if not self.resource_path.is_empty():
			ResourceSaver.save(self, self.resource_path)

func _init(p_controller_scheme = 3):
	controller_scheme = p_controller_scheme
