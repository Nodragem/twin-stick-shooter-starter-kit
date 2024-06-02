extends ConditionLeaf


func tick(actor, blackboard):
	if actor.current_state == actor.BehaviorState.Idling:
		return SUCCESS
	else:
		return FAILURE
