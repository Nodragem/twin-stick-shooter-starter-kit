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
	if parent != null and parent.position.y < -1:
		reset_position()


func reset_position():
	parent.global_transform = initial_position
