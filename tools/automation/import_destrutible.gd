@tool # Needed so it runs in editor.
extends EditorScenePostImport

# Called right after the scene is imported and gets the root node.
func _post_import(scene):
	print("Adding script and collision shape to ", scene.name)
	var body:RigidBody3D = CollisionTool.add_kinematic_body_to_mesh(scene.get_child(0), scene)
	print("Collision Added!")
	scene.set_script(preload("res://assets/destructible.gd"))
	scene.body = body
	scene.explosion = preload("res://objects/SmokeExplosion.tscn")
	print("Destructible Script Added!")
	return scene # Remember to return the imported scene


