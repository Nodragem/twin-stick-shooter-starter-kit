extends ActionLeaf


func tick(actor, blackboard):
	actor.play_attacking(true)
	return SUCCESS
