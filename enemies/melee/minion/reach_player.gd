extends ActionLeaf

var physics_delta_time
var delta_time
var target_reached = false
@export var target_object:PlayerEntity = null

func tick(actor, blackboard):
	if not actor.target_reached.is_connected(_target_reached):
		actor.target_reached.connect(_target_reached)
	if self.target_reached:
		self.target_reached = false
		actor.target_reached.disconnect(_target_reached)
		return SUCCESS
	if target_object != null:
		actor.set_movement_target(target_object.position)
		physics_delta_time = get_physics_process_delta_time()
		delta_time = get_process_delta_time()
		actor.update_animation_skin(delta_time)
		actor.update_navigation_agent(physics_delta_time, target_object)
		return RUNNING
	else:
		return FAILURE
	

func _target_reached():
	self.target_reached = true
