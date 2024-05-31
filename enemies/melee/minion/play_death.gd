extends ActionLeaf


func tick(actor, blackboard):
	actor.move_to_dying()
	return SUCCESS
	
