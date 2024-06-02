extends ActionLeaf


func tick(actor, blackboard):
	actor.play_attacking(true)
	actor.current_state = actor.BehaviorState.Attacking
	return SUCCESS
