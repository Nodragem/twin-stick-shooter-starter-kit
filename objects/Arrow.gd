extends RigidBody3D
class_name Arrow

signal exploded

@export var initial_velocity = 25
@onready var impact_mesh = $ImpactMesh

var velocity = Vector3.ZERO


func _physics_process(delta):
	if velocity.length_squared() > 0.01:
		look_at(transform.origin + velocity.normalized(), Vector3.UP)
	

func _ready():
	impact_mesh.visible = false
	impact_mesh.scale = Vector3(1,1,1)
	await get_tree().create_timer(10.0).timeout # waits for 1 second
	queue_free()




func _on_body_entered(body):
	if impact_mesh:
		impact_mesh.visible = true
		#TODO: attach to wall and align with collision normal
		#impact_mesh.reparent(get_tree().get_root())
		var tween = self.create_tween()

		(tween.tween_property(impact_mesh, "scale", Vector3(), 0.1)
		.set_trans(Tween.TRANS_QUAD)
		.set_ease(Tween.EASE_IN))
		tween.parallel().tween_callback(func(): impact_mesh.visible = false).set_delay(0.06)
	
	if body is GridMap: # hit a wall
		self.remove_from_group("bullet")
		call_deferred("set_contact_monitor", false)
		self.max_contacts_reported = 0
