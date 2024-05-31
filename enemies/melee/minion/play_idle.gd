extends ActionLeaf


func tick(actor, blackboard):
	actor.move_to_idling()
	return SUCCESS
