class_name GameManager extends Node3D

@export var player_packed_scene:PackedScene = null
static var gameover_menu: Control = null
static var player:PlayerEntity = null
static var level:LevelManager = null

static func get_player()->PlayerEntity:
	return player

static func has_player()->bool:
	return true if player else false

static func on_pickup_item(name:String):
	if player:
		player.inventory.append(name)
	if not level:
		return
	if name == "building_card":
		level.on_card_picked_up()

func _ready():
	
	find_game_elements() # find player, level and gameovermenu
	if not player and level and level.skip_intro:
		spawn_player()
	if level: 
		level.introscene_finished.connect(initialise_player)
	if gameover_menu:
		gameover_menu.restart_pressed.connect(on_restart_pressed)
		gameover_menu.quit_pressed.connect(on_quit_pressed)


func find_game_elements():
	var children = get_children()
	for child in children:
		if child is PlayerEntity:
			player = child
		elif child is LevelManager:
			level = child
		elif child is GameOverMenu:
			gameover_menu = child


func initialise_player():
	if player:
		player.queue_free()
	spawn_player()
	player.camera.current = true



func spawn_player():
	player = player_packed_scene.instantiate()
	add_child(player)
	player.global_transform = level.player_start_point.global_transform
	player.camera_pivot.rotation_degrees = level.camera_start_rotation
	player.position_resetter.update_reset_position()


static func on_player_death():
	if gameover_menu:
		gameover_menu.show()

func on_quit_pressed():
	get_tree().quit()

func on_restart_pressed():
	player.position_resetter.reset_position()
	player.on_respawn()
	if gameover_menu: 
		gameover_menu.hide()
