# AimingController with Mouse: Aiming State
extends PlayerState

var arrow_prefab = preload("res://assets/objects/weapons/toy_gun/Arrow.tscn")
var _aiming_direction := Vector3.ZERO
var _aim_input := Vector2.ZERO
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
	player.model.orient_model_to_direction(_aiming_direction, delta)


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


func get_player_position_2D():
	return get_viewport().get_camera_3d().unproject_position(player.global_position)


func _update_player_input():
	# get input for aiming
	_aim_input = get_viewport().get_mouse_position() - get_player_position_2D()
	_aim_input = _aim_input.normalized()
	# move it to a 3D vector:
	_aiming_direction.x = _aim_input.x
	_aiming_direction.z = _aim_input.y
	_aiming_direction.y = 0
	_aiming_direction = player.camera.global_transform.basis * (_aiming_direction)
