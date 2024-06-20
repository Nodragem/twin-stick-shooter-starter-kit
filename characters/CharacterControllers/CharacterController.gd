extends Node
class_name CharacterController

var _parent:PlayerEntity
var _player_input
@export var _camera_rotation_speed = 0.05

# Called when the node enters the scene tree for the first time.
func _enter_tree():
	_parent = get_parent()
	print("Hello!")
	print("%s is waiting for his parent '%s'" % [self.name, _parent.name])
	await _parent.ready
	print("%s's parent '%s' is ready!" % [self.name, _parent.name])

func _ready():
	print("%s is Ready"%self.name)

func _process(delta) -> void:
	_update_player_input()


func _update_player_input():
	_player_input =  Input.get_action_raw_strength("p1_camera_RR") - Input.get_action_raw_strength("p1_camera_RL")
	_parent.camera_pivot.rotate_y(_player_input * _camera_rotation_speed)


func on_death():
	$MovementController.transition_to("Dead")
	$AimingController.transition_to("Dead")
