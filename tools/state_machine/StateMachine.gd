@icon("res://tools/state_machine/state_machine.svg")
class_name StateMachine
extends Node

signal transitioned(state_path)

@export var initial_state: = NodePath() 
@onready var state: State = get_node(initial_state): set = set_state
var _state_name: = ""


func _init() -> void:
	add_to_group("state_machine")
	DebugStats.add_property(self, "state:name", "")

func _ready() -> void:
	print("State Machine ", self.name, " is waiting for root ", get_tree().root)
	await get_tree().root.ready
	print("Root is ready!")
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func _process(delta: float) -> void:
	state.process(delta)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)


func transition_to(target_state_path: String, msg: = {}) -> void:
	assert(has_node(target_state_path), "ERROR: the State %s does not exist!"%target_state_path)
	
	var target_state: = get_node(target_state_path)
	
	state.exit()
	self.state = target_state
	state.enter(msg)
	emit_signal("transitioned", target_state_path)

func set_state(value: State) -> void:
	state = value
	_state_name = state.name
	
