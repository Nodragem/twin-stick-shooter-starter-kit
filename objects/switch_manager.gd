extends Switch
class_name SwitchHub

var switch_emitters:Array[Switch] = []
var switch_receivers:Array[Switch] = []
var nb_activated_switches = 0
var nb_switches = -1


func _ready():
	DebugStats.add_property(self, "nb_activated_switches", "")
	var children = get_children()
	for child in children:
		if child.is_in_group("switch_emitter"):
			switch_emitters.append(child)
			child.activation_signal.connect(on_interaction)
		if child.is_in_group("switch_receiver"):
			switch_receivers.append(child)
			self.activation_signal.connect(child.on_interaction)
	nb_switches = switch_emitters.size()
	update_activation_sum()


func on_interaction(requested:bool):
	print("variable received: ", requested)
	update_activation_sum()


func update_activation_sum():
	nb_activated_switches = 0
	for switch in switch_emitters:
		nb_activated_switches += int(switch.inversed_switch != switch.is_activated) # based on the true/false matrix
	if nb_activated_switches >= nb_switches:
		is_activated = true
		# matrix:
		# inversed | activated | result
		#        0 |         0 |      0
		#        0 |         1 |      1
		#        1 |         0 |      1
		#        1 |         1 |      0
