extends ActionLeaf


func tick(actor, blackboard):
	actor.move_to_idling()
	actor.current_state = actor.BehaviorState.Idling
	return SUCCESS
