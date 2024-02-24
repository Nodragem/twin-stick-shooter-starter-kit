extends State
class_name PlayerState

var player: PlayerEntity
var model: PlayerSkin
var camera: Camera3D
var anim_tree: AnimationTree
var shoot_anchor: Marker3D

func _ready() -> void:
	super._ready()
	print("PlayerState ", self.name, " is owned by ", owner)
	await owner.ready # probably not needed
	print("PlayerState ", self.name, " is initialising")
	player = owner
	model = player.model
	camera = player.camera_controller
	anim_tree = player.anim_tree
	shoot_anchor = player.shoot_anchor
