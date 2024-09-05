# MovementController for ALL controller modes
extends PlayerState

@export var max_speed: = 15.0
@export var acceleration:= 50
@export var gravity: = -30.0
@export var snap_length := 0.5
@export var do_stop_on_slope := true

var _switch_component :SwitchComponent = null
var _move_direction := Vector3.ZERO
var _player_input := Vector3.ZERO
var _is_directing := true
var velocity: Vector3:
	get:
		return player.velocity
	set(value):
		player.velocity = value

func _ready():
	super._ready()
	DebugStats.add_property(self, "_is_directing", "")

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("p1_jump") and player.is_on_floor():
		_state_machine.transition_to("Move/Jump", {velocity = player.velocity})
	
	# TODO: I dont like that this logic is in the Player
	# The logic of the switch input should be in the switch? 
	if event.is_action_pressed("p1_interact") and player.is_on_floor():
		print("button interacting pressed.")
		var interactibles = player.interaction_area.get_overlapping_areas()
		for area:Area3D in interactibles:
			print("Interactible Objects found!")
			var switch_component = area.get_node_or_null("SwitchComponent")
			if switch_component:
				print("SwitchComponent found!")
				_switch_component = switch_component
				_switch_component.on_interaction(true) 
	if event.is_action_released("p1_interact") or not player.is_on_floor():
		print("button interacting released")
		if _switch_component and is_instance_valid(_switch_component): 
			_switch_component.on_interaction(false)

func physics_process(delta: float) -> void:
	_update_player_input()
	
	_move_direction.x = _player_input.x
	_move_direction.z = _player_input.z
	
	_update_velocity(delta)
	player.floor_snap_length = snap_length
	player.floor_stop_on_slope = do_stop_on_slope
	player.move_and_slide()
	
	if _is_directing and _player_input.length_squared() > 0.01: # last condition is made so that the player does not start face up
		player.model.orient_model_to_direction(_move_direction, delta)
	player.model.update_move_animation(velocity.length() / max_speed, delta)


func _update_player_input():
	var input = Input.get_vector("p1_move_left", "p1_move_right", "p1_move_up", "p1_move_down")
	_player_input = Vector3(input.x, 0, input.y)
	
	# align input with the camera 
	_player_input = player.camera.global_transform.basis * (_player_input)
	_player_input.y = 0
	# remove the following if you want character to be slower with how much you push the joystick
	_player_input = _player_input.normalized()


func _update_velocity(delta: float):
	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.lerp(_move_direction * max_speed, acceleration * delta)
	
	velocity.y = y_velocity + gravity * delta # preserve y


func _on_aim_enter_state():
	_is_directing = false


func _on_aim_exit_state():
	_is_directing = true
