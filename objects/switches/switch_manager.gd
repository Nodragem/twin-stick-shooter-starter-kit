extends SwitchComponent
class_name SwitchHub



func on_interaction(requested:bool):
	print("variable received: ", requested)
	get_parent().update_activation_sum()
