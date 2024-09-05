# AimingController with Mouse: Aiming State
extends PlayerState

var arrow_prefab = preload("res://assets/objects/weapons/toy_gun/Arrow.tscn")
var _player_aim := Vector3.ZERO
var _mouse_position := Vector2.ZERO
var _mouse_position_3D := Vector3.ZERO
var _floor_plane := Plane(Vector3.UP)
var _player_trigger := false
@onready var _timer : Timer = $Timer


func process(delta) -> void:
	_update_player_input()
	if _timer.time_left <= 0: 
		# NOTE: we tried with event handling, but weirdly the deadzone was noisy, 
		# 1) it would trigger many bullets when near the deadzone
		# 2) it would trigger a second bullet on release
		_timer.start()
		_shoot_arrow()
	player.model.orient_model_to_direction(_player_aim, delta)


func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_released():
		if event.button_index == MOUSE_BUTTON_LEFT:
			_state_machine.transition_to("Rest")


func enter(msg: = {}) -> void:
	super(msg) # parent send a signal and we dont want to override it!
	player.model.play_aiming(true)
	_timer.start() 
	# NOTE: we delay the start of the shooting, kind of sucks for reactivity but
	# the character skin needs to finish its aiming animation

func _shoot_arrow() -> void:
	var arrow = arrow_prefab.instantiate()
	get_tree().current_scene.add_child(arrow)
	arrow.global_transform = player.shoot_anchor.global_transform
	arrow.apply_central_impulse(arrow.transform.basis.z * arrow.initial_velocity)
	player.model.play_shooting(true)

## in this version we project the mouse on the floor
func _update_player_input():
	_mouse_position = get_viewport().get_mouse_position() 
	# we place the floor at the same height as the feet of the player:
	_floor_plane.d = player.global_position.y 
	# project the mouse on the floor
	_mouse_position_3D = _floor_plane.intersects_ray(
			player.camera.project_ray_origin(_mouse_position),
			player.camera.project_ray_normal(_mouse_position))
	# player_aim tells where is the mouse relatively to the player
	_player_aim = _mouse_position_3D - player.global_position
	_player_aim.y = 0
