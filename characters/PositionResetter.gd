extends Node

var parent: Node3D = null
var initial_position:Transform3D = Transform3D.IDENTITY

func _ready() -> void:
	await owner.ready
	parent = get_parent()
	if not parent.is_class("Node3D"):
		parent = null
	else:
		initial_position = parent.global_transform

func _physics_process(delta: float) -> void:
	if parent != null and parent.position.y < -1:
		reset_position()


func update_reset_position(new_transform:Transform3D=Transform3D.IDENTITY):
	if new_transform == Transform3D.IDENTITY and parent != null:
		initial_position = parent.global_transform
	else:
		initial_position = new_transform.orthonormalized() # in case the scale is not 1


func reset_position():
	parent.global_transform = initial_position
