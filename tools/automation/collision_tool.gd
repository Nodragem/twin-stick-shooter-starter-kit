class_name CollisionTool extends RefCounted

static func add_static_body_to_mesh(mesh_instance, new_owner):
	var body = StaticBody3D.new()
	mesh_instance.add_child(body)
	body.transform = Transform3D() #center it on the parent
	body.owner = new_owner
	
	var coll_shape = CollisionShape3D.new()
	coll_shape.shape = generate_aabb_box_shape(mesh_instance)
	body.add_child(coll_shape)
	coll_shape.transform = Transform3D()
	coll_shape.position = mesh_instance.mesh.get_aabb().get_center()
	coll_shape.owner = new_owner
	return body


static func add_kinematic_body_to_mesh(mesh_instance, new_owner):
	var body = RigidBody3D.new()
	mesh_instance.add_child(body)
	body.transform = Transform3D() #center it on the parent
	body.owner = new_owner
	
	var coll_shape = CollisionShape3D.new()
	coll_shape.shape = generate_aabb_box_shape(mesh_instance)
	body.add_child(coll_shape)
	coll_shape.transform = Transform3D()
	coll_shape.position = mesh_instance.mesh.get_aabb().get_center()
	coll_shape.owner = new_owner
	
	# make it Kinematic
	body.freeze = true
	body.freeze_mode = RigidBody3D.FREEZE_MODE_KINEMATIC
	# necessary for detecting collision (off by default)
	body.contact_monitor = true
	body.max_contacts_reported = 1
	# collision with
	body.set_collision_layer_value(1, false)
	body.set_collision_layer_value(4, true) # it is an object
	body.set_collision_mask_value(1, true) # it collides with players
	body.set_collision_mask_value(3, true) # and with bullets
	return body
	


static func generate_aabb_box_shape(mesh_instance):
	var simplified_shape = BoxShape3D.new()
	var aabb = mesh_instance.mesh.get_aabb()
	simplified_shape.extents = Vector3(aabb.size/2)
	return simplified_shape
