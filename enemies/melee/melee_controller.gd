extends Node
class_name MeleeController

@export var movement_speed: float = 8.0
@export var target_object:Node3D = null

var entity:EnemyEntity = null
var gravity = -30.0
var anim_state = null
var health = 3

func _enter_tree():
	entity = get_parent()

func _ready() -> void:
	await entity.ready
	entity.navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	DebugStats.add_property(entity, "velocity", "")

func set_movement_target(movement_target: Vector3):
	entity.navigation_agent.set_target_position(movement_target)

func _process(delta):
	if target_object:
		set_movement_target(target_object.position)
	anim_state = entity.model.anim_tree["parameters/state/current_state"]
	if  anim_state == "Idling" and entity.velocity.length_squared() > 0.01:
		entity.model.move_to_running()
	if anim_state == "Running":
		entity.model.orient_model_to_direction(Vector3(entity.velocity.x,0, entity.velocity.z), delta)
		if entity.velocity.length_squared() <= 0.01:
			entity.model.move_to_idling()
	if health <= 0:
		entity.model.move_to_dying()

func _physics_process(delta):
	if entity.navigation_agent.is_navigation_finished():
		entity.velocity = Vector3(0,0,0)
		return

	var next_path_position: Vector3 = entity.navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = entity.global_position.direction_to(next_path_position) * movement_speed
	new_velocity.y = entity.velocity.y + gravity*delta
	if entity.navigation_agent.avoidance_enabled:
		entity.navigation_agent.set_velocity(new_velocity)
	else:# we call it manually because only called by set_velocity when avoidance is true
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	entity.velocity = safe_velocity
	entity.move_and_slide()
