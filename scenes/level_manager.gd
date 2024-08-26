class_name LevelManager extends Node3D

@export var skip_intro:bool = false
@export var camera_start_rotation:Vector3 = Vector3(-35, 60, 0)
@onready var player_start_point:Marker3D = %PlayerStartingPoint
signal cutscene_finished

func _ready():
	if not skip_intro:
		$CutSceneManager.animation_finished.connect(on_cutscene_finished)
		$CutSceneManager.play("Scene1_Introduction")
		$CutSceneManager.seek(27.99,true)
	else:
		$CutSceneManager.process_mode = Node.PROCESS_MODE_DISABLED

func on_cutscene_finished(anim_name:String):
	if anim_name == "Scene1_Introduction":
		cutscene_finished.emit()
		$CutSceneManager.play("Opening")
	if anim_name == "Opening":
		$CutSceneManager.process_mode = Node.PROCESS_MODE_DISABLED
