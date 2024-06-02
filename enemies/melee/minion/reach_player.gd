extends ActionLeaf

var physics_delta_time
var delta_time
var target_reached = false
var target_lost = false

func tick(actor, blackboard):
	if actor.current_state != actor.BehaviorState.Reaching:
		actor.current_state = actor.BehaviorState.Reaching
	if actor.is_target_in_reach:
		return SUCCESS
	if actor.target_object != null:
		actor.set_movement_target(actor.target_object.position)
		physics_delta_time = get_physics_process_delta_time()
		delta_time = get_process_delta_time()
		actor.update_animation_skin(delta_time)
		actor.update_navigation_agent(physics_delta_time, actor.target_object)
		return RUNNING
	else:
		return FAILURE
