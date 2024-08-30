class_name LevelManager extends Node3D

@export var skip_intro:bool = false

@export var camera_start_rotation:Vector3 = Vector3(-35, 60, 0)
@onready var player_start_point:Marker3D = %PlayerStartingPoint

signal introscene_finished

func _ready():
	# NOTE: both the animation player or the dialog system can flag the end of a cutscene
	# depending on whether the cutscene is dialog-driven or animation-driven.
	$CutSceneManager.animation_finished.connect(on_cutscene_finished)
	Dialogic.signal_event.connect(on_cutscene_finished)
	
	if not skip_intro:
		$CutSceneManager.play("Scene1_Introduction")
		#$CutSceneManager.seek(27.99,true)
	else:
		$CutSceneManager.process_mode = Node.PROCESS_MODE_DISABLED

func on_cutscene_finished(anim_name:String):
	if anim_name == "Scene1_Introduction":
		introscene_finished.emit() #Gamemanager will spawn a player and change camera
		Dialogic.Inputs.resume()
		$CutSceneManager.play("Opening")
	if anim_name == "Opening":
		$CutSceneManager.process_mode = Node.PROCESS_MODE_DISABLED
		Dialogic.start("level1_drmegadroon")
	if anim_name == "Scene2_Ending":
		GameManager.get_player().camera.current = true
		var switch:SwitchComponent = %DoorToTraining.get_node_or_null("SwitchComponent")
		switch.on_interaction(true)
		$CutSceneManager.play("Simple_Transition")
	if anim_name == "Simple_Transition":
		$CutSceneManager.process_mode = Node.PROCESS_MODE_DISABLED
		

func on_card_picked_up():
	$CutSceneManager.process_mode = Node.PROCESS_MODE_INHERIT
	$CutSceneManager.get_camera().current = true
	$CutSceneManager.play("Scene2_Opening_Training")
	
func on_gun_picked_up():
	pass
