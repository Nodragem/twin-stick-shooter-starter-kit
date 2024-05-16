extends PlayerState

const IDLE_BREAK_WAIT_TIME := 5.0
var _break_timer := Timer.new()

func _ready() -> void:
	await super._ready()
	# await owner.ready
	add_child(_break_timer)
	_break_timer.wait_time = IDLE_BREAK_WAIT_TIME
	_break_timer.one_shot = false
	await get_tree().root.ready
	_break_timer.connect("timeout", Callable(player.model, "play_idle_break").bind(true))
	

func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if player.is_on_floor() and _parent.velocity.length() > 0.01:
		_state_machine.transition_to("Move/Run")


func enter(msg: = {}) -> void:
	_break_timer.start(IDLE_BREAK_WAIT_TIME)
	player.model.move_to_running()
	_parent.velocity = Vector3.ZERO
	_parent.enter(msg)


func exit() -> void:
	player.model.play_idle_break(false)
	_break_timer.stop()
	_parent.exit()
