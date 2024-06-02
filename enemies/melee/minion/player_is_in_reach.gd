class_name PlayerIsInReach extends ConditionLeaf


func tick(actor, blackboard):
	if actor.is_target_in_reach:
		return SUCCESS
	else:
		return FAILURE
