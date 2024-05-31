extends ConditionLeaf


func tick(actor, blackboard):
	if actor.current_state == actor.EnemyState.Idling:
		return SUCCESS
	else:
		return FAILURE
