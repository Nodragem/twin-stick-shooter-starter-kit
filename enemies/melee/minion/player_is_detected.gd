class_name PlayerIsDetected extends ConditionLeaf


func tick(actor, blackboard):
	if actor.is_player_detected:
		return SUCCESS
	else:
		return FAILURE
