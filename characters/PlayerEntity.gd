class_name PlayerEntity
extends CharacterBody3D

@onready var camera := $CameraPivot/ThirdPersonCamera
@onready var camera_pivot := $CameraPivot
@onready var model := $IcySkin
@onready var health_manager := $HealthManager
@onready var anim_tree := $IcySkin/AnimationTree
@onready var shoot_anchor := $IcySkin/%ShootAnchor
@onready var current_controller := $TwoStickControllerAuto
@onready var start_position := global_transform.origin

@export var controller_schemes:Array[PackedScene]

@export var game_data:GameDataStore

func _ready():
	game_data.controller_scheme_changed.connect(_on_controller_scheme_changed)
	if health_manager and model:
		health_manager.damage.connect(model.play_on_hit.bind(true))


func on_death():
	model.play_death()
	current_controller.paused = true
	

func _on_controller_scheme_changed(value):
	pass
	if current_controller:
		current_controller.queue_free()
	var new_controller = controller_schemes[value].instantiate()
	add_child(new_controller)
	new_controller.owner = self
	current_controller = new_controller
