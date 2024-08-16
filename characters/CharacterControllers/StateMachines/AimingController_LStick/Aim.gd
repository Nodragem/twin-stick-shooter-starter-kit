extends PlayerState

var arrow_prefab = preload("res://assets/objects/weapons/toy_gun/Arrow.tscn")

func unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("p1_aim"):
		_state_machine.transition_to("Rest")
	if event.is_action_pressed("p1_shoot"):
		_shoot_arrow()


func enter(msg: = {}) -> void:
	super(msg)
	player.model.play_aiming(true)

func _shoot_arrow() -> void:
	var arrow = arrow_prefab.instantiate()
	get_tree().current_scene.add_child(arrow)
	arrow.global_transform = player.shoot_anchor.global_transform
	arrow.apply_central_impulse(arrow.transform.basis.z * arrow.initial_velocity)
