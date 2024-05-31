class_name MeleeSkin
extends Node

@onready var anim_tree: AnimationTree = $AnimationTree
@export var rotation_speed := 12.0

var transition:AnimationNodeTransition=null
var _last_strong_direction := Vector3.FORWARD

func _ready() -> void:
	anim_tree.active = true
	transition = anim_tree.tree_root.get("nodes/state/node")


func move_to_running() -> void:
	transition.xfade_time = 0.1
	anim_tree["parameters/state/transition_request"] = "Running"


func move_to_idling() -> void:
	transition.xfade_time = 0.1
	anim_tree["parameters/state/transition_request"] = "Idling"


func move_to_dying() -> void:
	transition.xfade_time = 0
	anim_tree["parameters/state/transition_request"] = "Dying"


func play_attacking(is_requested: bool) -> void:
	if is_requested:
		anim_tree["parameters/on_attacking/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	else:
		anim_tree["parameters/on_attacking/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FADE_OUT
	

func orient_model_to_direction(direction: Vector3, delta: float) -> void:
	# METHOD 1:
	# model.look_at(player.global_transform.origin +\
	# _move_direction, Vector3.UP)
	
	if direction.length() > 0.2:
		_last_strong_direction = direction
	
	# METHOD 2:
	var left_axis := Vector3.UP.cross(_last_strong_direction)
	var rotation_basis := Basis(left_axis, Vector3.UP, _last_strong_direction)\
	.orthonormalized()
	
	# in what sense is it different from transform.look_at + interpolate_with?
	self.transform.basis = self.transform.basis\
	.orthonormalized()\
	.slerp(rotation_basis, delta * rotation_speed)\
	.scaled(self.scale)
