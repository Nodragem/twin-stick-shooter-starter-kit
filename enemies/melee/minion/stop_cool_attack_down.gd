extends ActionLeaf

@export var attack_cooldown: CooldownDecorator

func tick(actor, blackboard):
	if attack_cooldown:
		var key = attack_cooldown.cache_key
		blackboard.set_value(key, 0, str(actor.get_instance_id()))
		return SUCCESS
	else:
		return FAILURE
