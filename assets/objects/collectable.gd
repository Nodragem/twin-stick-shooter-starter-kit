class_name Collectable extends Area3D

@export var item_mesh:Mesh = null

signal pickedup(object_name:String)
var tweens:Array[Tween] = []

func _ready():
	self.pickedup.connect(GameManager.on_pickup_item)
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


func on_picked_up():
	var item_name = item_mesh.get_meta("object", "")
	pickedup.emit(item_name) # GameManager will take care of adding item to player
	tweens.map(func(x): x.kill())
	self.queue_free()
