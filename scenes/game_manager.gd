extends Node3D

@export var player_packed_scene:PackedScene = null
@onready var gameover_menu: Control = $GameOverMenu
var player:PlayerEntity = null
var level:LevelManager = null

func _ready():
	gameover_menu.restart_pressed.connect(on_restart_pressed)
	gameover_menu.quit_pressed.connect(on_quit_pressed)
	find_player_and_level()
	if not player and level.skip_intro:
		spawn_player()
	level.cutscene_finished.connect(start_level)


func find_player_and_level():
	var children = get_children()
	for child in children:
		if child is PlayerEntity:
			player = child
		elif child is LevelManager:
			level = child


func start_level():
	if player:
		player.queue_free()
	spawn_player()
	player.camera.current = true


func spawn_player():
	player = player_packed_scene.instantiate()
	add_child(player)
	player.global_transform = level.player_start_point.global_transform
	player.camera_pivot.rotation_degrees = level.camera_start_rotation


func on_player_death():
	if gameover_menu:
		gameover_menu.show()

func on_quit_pressed():
	get_tree().quit()

func on_restart_pressed():
	get_tree().reload_current_scene()
