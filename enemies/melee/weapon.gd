extends MeshInstance3D
class_name Weapon

@export var hit_area: Area3D
@export var attack_damage: float = 1
var bodies: Array[Node3D] = []


func deal_damage():
	if hit_area.has_overlapping_bodies():
		bodies  = hit_area.get_overlapping_bodies()
		for body in bodies:
			if body is PlayerEntity:
				body.health_manager.get_damage(attack_damage) 
