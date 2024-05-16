@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	for child in get_scene().get_children():
		if child is not MeshInstance3D:
			continue
		print("building collision box for " + child.name + "...")
		CollisionTool.add_static_body_to_mesh(child, get_scene())
		print("> done!")



