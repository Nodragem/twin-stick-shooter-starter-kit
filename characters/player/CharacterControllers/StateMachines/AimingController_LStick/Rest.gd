extends PlayerState

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("p1_aim"):
		_state_machine.transition_to("Aim")

func enter(msg: = {}) -> void:
	super(msg)
	player.model.play_aiming(false)
