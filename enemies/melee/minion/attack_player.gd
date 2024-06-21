extends ActionLeaf


func tick(actor, blackboard):
	actor.move_to_idling()
	actor.current_state = actor.BehaviorState.Attacking
	actor.play_on_attacking(true)
	return SUCCESS
