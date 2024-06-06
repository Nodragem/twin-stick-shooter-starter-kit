extends ActionLeaf


func tick(actor, blackboard):
	actor.move_to_idling()
	actor.play_on_attacking(true)
	actor.current_state = actor.BehaviorState.Attacking
	return SUCCESS
