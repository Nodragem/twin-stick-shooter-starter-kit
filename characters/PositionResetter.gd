extends Node

var parent: Node3D = null
var initial_position = Vector3.ZERO

func _ready() -> void:
	await owner.ready
	parent = get_parent()
	if not parent.is_class("Node3D"):
		parent = null
	else:
		initial_position = parent.transform.origin

func _physics_process(delta: float) -> void:
	if parent != null and parent.position.y < -0.5:
		parent.position = initial_position
