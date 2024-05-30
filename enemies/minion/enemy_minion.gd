extends CharacterBody3D

@export var movement_speed: float = 8.0
@export var target_object:Node3D = null
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D
@onready var character_model: MinionSkin = $Skin_Minion

var gravity = -30.0
var anim_state = null
var health = 3

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	DebugStats.add_property(self, "velocity", "")

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)

func _process(delta):
	if target_object:
		set_movement_target(target_object.position)
	anim_state = character_model.anim_tree["parameters/state/current_state"]
	if  anim_state == "Idling" and velocity.length_squared() > 0.01:
		character_model.move_to_running()
	if anim_state == "Running":
		character_model.orient_model_to_direction(Vector3(velocity.x,0, velocity.z), delta)
		if velocity.length_squared() <= 0.01:
			character_model.move_to_idling()
	if health <= 0:
		character_model.move_to_dying()

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		velocity = Vector3(0,0,0)
		return

	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var new_velocity: Vector3 = global_position.direction_to(next_path_position) * movement_speed
	new_velocity.y = velocity.y + gravity*delta
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:# we call it manually because only called by set_velocity when avoidance is true
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector3):
	velocity = safe_velocity
	move_and_slide()
