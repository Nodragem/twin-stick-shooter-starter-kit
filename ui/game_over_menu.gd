class_name GameOverMenu extends Control

signal restart_pressed
signal quit_pressed

func _ready():
	visible = false


func _on_visibility_changed():
	if visible == true and $"%Restart".is_inside_tree():
		$"%Restart".grab_focus()


func _on_restart_pressed():
	restart_pressed.emit()


func _on_quit_pressed():
	quit_pressed.emit()
