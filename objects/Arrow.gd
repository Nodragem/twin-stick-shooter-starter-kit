extends RigidBody3D
class_name Arrow

signal exploded

@export var initial_velocity = 25

var velocity = Vector3.ZERO


func _physics_process(delta):
	if velocity.length_squared() > 0.01:
		look_at(transform.origin + velocity.normalized(), Vector3.UP)
	

func _ready():
	await get_tree().create_timer(10.0).timeout # waits for 1 second
	queue_free()




func _on_body_entered(body):
	if body is GridMap: # hit a wall
		self.remove_from_group("bullet")
		call_deferred("set_contact_monitor", false)
		self.max_contacts_reported = 0
