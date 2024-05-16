extends State
class_name PlayerState

var player: PlayerEntity
var character_controller: CharacterController

func _ready() -> void:
	await super._ready()
	character_controller = owner
	player = character_controller.get_parent()
