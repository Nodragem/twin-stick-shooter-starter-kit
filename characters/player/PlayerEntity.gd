class_name PlayerEntity
extends CharacterBody3D

@onready var camera:Camera3D = $CameraPivot/ThirdPersonCamera
@onready var camera_pivot:Node3D = $CameraPivot
@onready var model := $IcySkin
@onready var health_manager := $HealthManager
@onready var anim_tree := $IcySkin/AnimationTree
@onready var shoot_anchor := $IcySkin/%ShootAnchor
@onready var current_controller := $TwoStickControllerAuto
@onready var interaction_area := $IcySkin/PlayerHand
@onready var start_position := global_transform.origin

@export var controller_schemes:Array[PackedScene]
@export var game_data:GameDataStore

@export var inventory:Array = []
signal is_dead

func _ready():
	game_data.controller_scheme_changed.connect(_on_controller_scheme_changed)
	Dialogic.timeline_started.connect(_on_dialog_started)
	Dialogic.timeline_ended.connect(_on_dialog_ended)
	
	#if health_manager:
		#health_manager.damage.connect(on_hit)
		#health_manager.health_depleted.connect(on_death)


func on_hit():
	model.play_on_hit(true)


func on_death():
	is_dead.emit()
	model.move_to_dead()
	#current_controller.process_mode = Node.PROCESS_MODE_DISABLED
	current_controller.on_death()
	

func respawn():
	pass

func _on_dialog_started():
	current_controller.process_mode = Node.PROCESS_MODE_DISABLED

func _on_dialog_ended():
	current_controller.process_mode = Node.PROCESS_MODE_INHERIT

func _on_controller_scheme_changed(value):
	pass
	if current_controller:
		current_controller.queue_free()
	var new_controller = controller_schemes[value].instantiate()
	add_child(new_controller)
	new_controller.owner = self
	current_controller = new_controller
