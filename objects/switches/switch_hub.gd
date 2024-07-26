extends Node3D

## SwitchHub is_activated is true if all conditions are met.
## it needs to forward true when inversed_polarity is false
## to forward false when inversed_polarity is true

@export var switch_emitters:Array[Node] = []
@export var switch_receivers:Array[SwitchConnection] = []

var receiver_components:Array[SwitchComponent] = []
var receiver_polarities:Array[bool] = []

var nb_activated_switches = 0
var nb_switches = -1


func _ready():

	DebugStats.add_property(self, "nb_activated_switches", "")
	
	for emitter in switch_emitters:
		if emitter.process_mode == PROCESS_MODE_DISABLED:
			continue
		var switch_component:SwitchComponent = emitter.get_node("SwitchComponent")
		if not switch_component:
			print("Error: no switch component found in ", emitter.name, "in switch hub: ", self.name)
			continue
		switch_component.activation_signal.connect($SwitchComponent.on_interaction)
	
	for connection in switch_receivers:
		var receiver = get_node(connection.switch)
		if receiver.process_mode == PROCESS_MODE_DISABLED:
			continue
		var switch_component:SwitchComponent = receiver.get_node_or_null("SwitchComponent")
		var inversed_polarity = connection.inverse_polarity
		
		if not switch_component:
			print("Error: no switch component found in ", receiver.name, "in switch hub: ", self.name)
			continue
		receiver_components.append(switch_component)
		receiver_polarities.append(inversed_polarity)
	
	# we need to tweak the activation signal being sent before to send it
	# we cannot connect to the same method multiple times with different binding
	# so we need to aggregate to one function call.
	$SwitchComponent.activation_signal.connect(send_on_interaction)
	
	nb_switches = switch_emitters.size()
	update_activation_sum()

func send_on_interaction(requested):
	## useful matrix to understand why we use inversed != requested:
	##		# inversed | activated | result
	##		#        0 |         0 |      0
	##		#        0 |         1 |      1
	##		#        1 |         0 |      1
	##		#        1 |         1 |      0
	for i in len(receiver_components):
		receiver_components[i].on_interaction(receiver_polarities[i] != requested)

func update_activation_sum():
	nb_activated_switches = 0
	for switch in switch_emitters:
		nb_activated_switches += int(switch.get_node("SwitchComponent").inversed_switch != switch.get_node("SwitchComponent").is_activated) # based on the true/false matrix
	if nb_activated_switches >= nb_switches:
		$SwitchComponent.is_activated = true
#	else:
#		$SwitchComponent.is_activated = false
