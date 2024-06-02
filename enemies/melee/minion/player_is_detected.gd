class_name PlayerIsDetected extends ConditionLeaf


func tick(actor, blackboard):
	if actor.is_target_detected:
		return SUCCESS
	else:
		return FAILURE
