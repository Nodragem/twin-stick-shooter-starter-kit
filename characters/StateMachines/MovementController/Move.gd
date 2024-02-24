extends PlayerState

@export var max_speed: = 15.0
@export var acceleration:= 50
@export var gravity: = -30.0
@export var snap_length := 0.5
@export var do_stop_on_slope := true
@export var has_infinite_inertia := true

var _move_direction := Vector3.ZERO
var _player_input := Vector3.ZERO
var _input_origin := Transform2D.IDENTITY #TODO
var velocity: Vector3:
	get:
		return player.velocity
	set(value):
		player.velocity = value
# var snap_length: Vector3:
# 	get:
# 		return player.snap_length
# 	set(value):
# 		player.snap_length = value


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("p1_jump") and player.is_on_floor():
		_state_machine.transition_to("Move/Jump", {velocity = player.velocity})


func physics_process(delta: float) -> void:
	_update_player_input()
	
	_move_direction.x = _player_input.x
	_move_direction.z = _player_input.z
	
	_update_velocity(delta)
	player.floor_snap_length = snap_length
	player.floor_stop_on_slope = do_stop_on_slope
	player.move_and_slide()
	
	model.update_animation(_move_direction, velocity.length() / max_speed, delta)


func _update_player_input():
	var input = Input.get_vector("p1_move_left", "p1_move_right", "p1_move_up", "p1_move_down")
	_player_input = Vector3(input.x, 0, input.y)
	
	_player_input = camera.global_transform.basis * (_player_input)
	_player_input.y = 0
	_player_input = _player_input.normalized()


func _update_velocity(delta: float):
	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.lerp(_move_direction * max_speed, acceleration * delta)
	
	velocity.y = y_velocity + gravity * delta # preserve y


