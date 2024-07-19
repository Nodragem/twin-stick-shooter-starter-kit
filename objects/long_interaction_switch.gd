extends Switch
class_name LongSwitch

enum {OFF, PROGRESSING, REGRESSING, ON}
var state = OFF
var progress: float = 0

@export_range(0,100) var progression_rate:float=10
@export_range(0,100) var regression_rate:float=10

@onready var anim_loading: AnimationPlayer = $AnimationLoading
@onready var anim_progress: AnimationPlayer = $AnimationProgression

func _ready():
	if is_activated:
		progress = 100

func _process(delta):
	if state == PROGRESSING:
		progress = min(100, progress + progression_rate*delta)
		anim_loading.play("switch_charging")
		if progress >= 100:
			state = ON
			anim_loading.stop()
			is_activated = true # cannot be reversed
			
	elif state == REGRESSING:
		progress = max(0, progress - regression_rate*delta)
		if progress <= 0:
			state = OFF
			is_activated = false

	anim_progress.play("progression_bar")
	anim_progress.seek(progress/100.0, -1, 0)
	
func on_interaction(requested:bool):
	if requested and (state == OFF or state == REGRESSING):
		state = PROGRESSING
		print("Progressing")

	if not requested and state == PROGRESSING:
		print("Regressing")
		state = REGRESSING
		anim_loading.stop()
