extends ConditionLeaf


func tick(actor, blackboard):
	if actor.health <= 0:
		return SUCCESS
	else:
		return FAILURE
