extends ActionLeaf

@export var hit_area: Area3D
@export var attack_damage: float = 1
var bodies: Array[Node3D] = []

func tick(actor, blackboard):
	actor.move_to_idling()
	actor.play_on_attacking(true)
	actor.current_state = actor.BehaviorState.Attacking
	if hit_area.has_overlapping_bodies():
		bodies  = hit_area.get_overlapping_bodies()
		for body in bodies:
			if body is PlayerEntity:
				body.get_damage(attack_damage) 
	return SUCCESS
