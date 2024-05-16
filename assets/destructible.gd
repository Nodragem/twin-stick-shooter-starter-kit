class_name Destructible extends Node3D
var healt_point = 2
var current_tween
@export var explosion:PackedScene
@export var body:RigidBody3D

func _ready():
	if body != null:
		body.body_entered.connect(self._on_frozen_body_entered)

func _input(event):
	# Use for test purposes
	if event.is_action_pressed("p1_jump"):
		healt_point -= 1
		run_animation()
		print("health: ", healt_point)
		if healt_point < 0:
			print("dead!")
			queue_free()
			run_explosion()

func run_animation():
	if current_tween != null and current_tween.is_running():
		current_tween.kill()
		self.scale = Vector3.ONE 
	current_tween = self.create_tween()
	current_tween.tween_property(self, "scale", Vector3(0.8,1.2,0.8), 0.2).set_trans(Tween.TRANS_BACK)
	current_tween.tween_property(self, "scale", Vector3.ONE, 0.1)
	#tween.tween_property(node, "modulate", Color.RED, 1)

func run_explosion():
	if explosion == null:
		return
	var node = explosion.instantiate()
	node.emitting = true
	node.position = self.position + Vector3(0,2,0)
	add_sibling(node)

func _on_frozen_body_entered(colliding_body):
	if colliding_body.is_in_group("bullet"):
		print("hit by", colliding_body.name, "!")
		healt_point -= 1
		colliding_body.remove_from_group("bullet")
		run_animation()
	if healt_point <= 0:
		queue_free()
		run_explosion()
