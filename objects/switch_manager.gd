extends SwitchComponent
class_name SwitchHub

var switch_emitters:Array[SwitchComponent] = []
var switch_receivers:Array[SwitchComponent] = []
var nb_activated_switches = 0
var nb_switches = -1


func _ready():
	DebugStats.add_property(self, "nb_activated_switches", "")
	var children = get_parent().get_children()
	for child in children:
		if child.process_mode == PROCESS_MODE_DISABLED:
			continue
		if child.is_in_group("switch_emitter"):
			var switch_component:SwitchComponent = child.get_node("SwitchComponent")
			switch_emitters.append(switch_component)
			switch_component.activation_signal.connect(on_interaction)
		if child.is_in_group("switch_receiver"):
			var switch_component:SwitchComponent = child.get_node("SwitchComponent")
			switch_receivers.append(switch_component)
			self.activation_signal.connect(switch_component.on_interaction)
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
