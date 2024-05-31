extends ConditionLeaf


func tick(actor, blackboard):
	if actor.current_state == actor.EnemyState.Dead:
		return SUCCESS
	else:
		return FAILURE
