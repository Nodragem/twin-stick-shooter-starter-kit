extends Node3D

@export var item_mesh:Mesh = null
@export var dialog_timeline: Resource = null
@export var jump_to_label: String = "OnDefault"

signal pickedup(object_name:String)
var tweens:Array[Tween] = []

func _ready():
	$AreaDialogue.dialog_timeline = dialog_timeline
	$AreaDialogue.jump_to_label = jump_to_label
	
	var mesh_instance = MeshInstance3D.new()
	$ItemSlot.add_child(mesh_instance)
	mesh_instance.mesh = item_mesh
	
	# center the mesh on the slot center, in case the mesh's origin is not centered
	var box:AABB = mesh_instance.get_aabb()
	mesh_instance.position = -box.get_center()
	
	# create animation
	tweens.append(create_tween().set_loops())
	tweens[0].tween_property($ItemSlot, "position", Vector3(0,0.5,0), 1).as_relative()
	tweens[0].tween_property($ItemSlot, "position", Vector3(0,-0.5,0), 1).as_relative()
	
	tweens.append(create_tween().set_loops())
	tweens[1].tween_property($ItemSlot, "rotation", Vector3(0, 360,0), 300).as_relative()


func _on_dialog_finished():
	pickedup.emit(item_mesh.get_meta("Object", ""))


func _on_dialog_started():
	$ItemSlot.visible = false
	$ItemSlot.process_mode=Node.PROCESS_MODE_DISABLED
	$AreaDialogue.visible = false
	$AreaDialogue.process_mode=Node.PROCESS_MODE_DISABLED
	tweens.map(func(x): x.kill())
