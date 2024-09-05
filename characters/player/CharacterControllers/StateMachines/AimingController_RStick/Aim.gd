# AimingController with RStick: Aiming State
extends PlayerState

var arrow_prefab = preload("res://assets/objects/weapons/toy_gun/Arrow.tscn")
var _aiming_direction := Vector3.ZERO
var _aim_input := Vector2.ZERO
var _player_trigger := false
@onready var _timer : Timer = $Timer


func process(delta) -> void:
	_update_player_input()
	if _aiming_direction.length() <= 0.2:
		_state_machine.transition_to("Rest")
	if _timer.time_left <= 0 and _player_trigger: 
		# NOTE: we tried with event handling, but weirdly the deadzone was noisy, 
		# 1) it would trigger many bullets when near the deadzone
		# 2) it would trigger a second bullet on release
		_timer.start()
		_shoot_arrow()

	player.model.orient_model_to_direction(_aiming_direction, delta)


func enter(msg: = {}) -> void:
	super(msg) # parent send a signal and we dont want to override it!
	player.model.play_aiming(true)


func _shoot_arrow() -> void:
	var arrow = arrow_prefab.instantiate()
	get_tree().current_scene.add_child(arrow)
	arrow.global_transform = player.shoot_anchor.global_transform
	arrow.apply_central_impulse(arrow.transform.basis.z * arrow.initial_velocity)


func _update_player_input():
	# get input for aiming
	_aim_input = Input.get_vector("p1_aim_left", "p1_aim_right", "p1_aim_up", "p1_aim_down")
	# align input with the camera
	_aiming_direction.x = _aim_input.x
	_aiming_direction.z = _aim_input.y
	_aiming_direction.y = 0
	_aiming_direction = player.camera.global_transform.basis * (_aiming_direction)

	# get input for shooting
	_player_trigger = Input.get_action_raw_strength("p1_aim") > 0.2 
	# TODO: need to change the name p1_aim
