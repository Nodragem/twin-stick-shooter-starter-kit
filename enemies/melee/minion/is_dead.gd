extends ConditionLeaf


func tick(actor, blackboard):
	if actor.current_state == actor.BehaviorState.Dead:
		return SUCCESS
	else:
		return FAILURE
