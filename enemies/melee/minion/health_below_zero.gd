extends ConditionLeaf


func tick(actor, blackboard):
	if actor.health_points <= 0:
		return SUCCESS
	else:
		return FAILURE
