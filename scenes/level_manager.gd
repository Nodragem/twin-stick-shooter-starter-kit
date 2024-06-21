extends Node3D

@onready var gameover_menu: Control = $GameOverMenu

func _ready():
	gameover_menu.restart_pressed.connect(on_restart_pressed)
	gameover_menu.quit_pressed.connect(on_quit_pressed)

func on_player_death():
	if gameover_menu:
		gameover_menu.show()

func on_quit_pressed():
	get_tree().quit()

func on_restart_pressed():
	get_tree().reload_current_scene()
