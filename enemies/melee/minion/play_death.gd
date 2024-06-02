extends ActionLeaf


func tick(actor, blackboard):
	actor.move_to_dying()
	actor.current_state = actor.BehaviorState.Dead
	return SUCCESS
	
