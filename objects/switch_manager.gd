extends Node
class_name SwitchHub

var switches:Array[Switch] = []
var nb_activated_switches = 0
var nb_switches = -1
var is_activated:bool = false:
	get: return is_activated
	set(value):
		is_activated = value
		hub_activated.emit(value)
signal hub_activated(is_activated)


func _ready():
	DebugStats.add_property(self, "nb_activated_switches", "")
	var children = get_children()
	for child in children:
		if child is Switch:
			switches.append(child)
			child.switched.connect(on_switch_changed.bind(child))
	nb_switches = switches.size()
	update_activation_sum()


func on_switch_changed(is_activated, switch):
	print("variable received: ", is_activated, switch)
	update_activation_sum()


func update_activation_sum():
	nb_activated_switches = 0
	for switch in switches:
		nb_activated_switches += int(switch.inversed_switch != switch.is_activated) # based on the true/false matrix
	if nb_activated_switches >= nb_switches:
		is_activated = true
		# matrix:
		# inversed | activated | result
		#        0 |         0 |      0
		#        0 |         1 |      1
		#        1 |         0 |      1
		#        1 |         1 |      0
