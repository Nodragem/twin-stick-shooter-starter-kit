extends Node

var parent: Spatial = null
var initial_position = Vector3.ZERO

func _ready() -> void:
	yield(owner, "ready")
	parent = get_parent()
	if not parent.is_class("Spatial"):
		parent = null
	else:
		initial_position = parent.transform.origin

func _physics_process(delta: float) -> void:
	if parent != null and parent.translation.y < -0.5:
		parent.translation = initial_position
