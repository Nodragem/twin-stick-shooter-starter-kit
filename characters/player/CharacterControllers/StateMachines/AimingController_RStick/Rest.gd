extends PlayerState

var _player_input := Vector2.ZERO

func unhandled_input(event: InputEvent) -> void:
	_update_player_input()
	if _player_input.length()>0.01 and player.inventory.has("toygun"):
		_state_machine.transition_to("Aim")

func enter(msg: = {}) -> void:
	super(msg)
	player.model.play_aiming(false)

func _update_player_input():
	_player_input = Input.get_vector("p1_aim_left", "p1_aim_right", "p1_aim_up", "p1_aim_down")
	
