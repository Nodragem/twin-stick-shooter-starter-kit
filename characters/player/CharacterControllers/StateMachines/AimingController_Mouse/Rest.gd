# AimingController with Mouse: Resting State
extends PlayerState

var _player_aim := Vector3.ZERO
var _aim_input := Vector2.ZERO


func unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT and player.inventory.has("toygun"):
			_state_machine.transition_to("Aim")


func get_player_position_2D():
	return get_viewport().get_camera_3d().unproject_position(player.global_position)


func enter(msg: = {}) -> void:
	super(msg)
	player.model.play_aiming(false)
