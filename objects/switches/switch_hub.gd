extends Node3D

@export var invert_signal:bool = false
@export var switch_emitters:Array[Node] = []
@export var switch_receivers:Array[Node] = []
var nb_activated_switches = 0
var nb_switches = -1


func _ready():
	if invert_signal:
		$SwitchComponent.inversed_signal = true

	DebugStats.add_property(self, "nb_activated_switches", "")
	
	for switch_emitter in switch_emitters:
		if switch_emitter.process_mode == PROCESS_MODE_DISABLED:
			continue
		if switch_emitter.is_in_group("switch_emitter"):
			var switch_component:SwitchComponent = switch_emitter.get_node("SwitchComponent")
			if not switch_component:
				print("Error: no switch component found in ", switch_emitter.name, "in switch hub: ", self.name)
				continue
			switch_component.activation_signal.connect($SwitchComponent.on_interaction)
	
	for switch_receiver in switch_receivers:
		if switch_receiver.process_mode == PROCESS_MODE_DISABLED:
			continue
		if switch_receiver.is_in_group("switch_receiver"):
			var switch_component:SwitchComponent = switch_receiver.get_node("SwitchComponent")
			if not switch_component:
				print("Error: no switch component found in ", switch_receiver.name, "in switch hub: ", self.name)
				continue
			$SwitchComponent.activation_signal.connect(switch_component.on_interaction)
	
	nb_switches = switch_emitters.size()
	update_activation_sum()


func update_activation_sum():
	nb_activated_switches = 0
	for switch in switch_emitters:
		nb_activated_switches += int(switch.get_node("SwitchComponent").inversed_switch != switch.get_node("SwitchComponent").is_activated) # based on the true/false matrix
	if nb_activated_switches >= nb_switches:
		$SwitchComponent.is_activated = true
		# matrix:
		# inversed | activated | result
		#        0 |         0 |      0
		#        0 |         1 |      1
		#        1 |         0 |      1
		#        1 |         1 |      0
