extends MarginContainer

class Property:
	var num_format = "%4.2f"
	var object  # The object being tracked.
	var property  # The property to display (NodePath).
	var label_ref  # A reference to the Label.
	var display  # Display option (rounded, etc.)

	func _init(_object, _property, _label, _display):
		object = _object
		property = _property
		label_ref = _label
		display = _display

	func set_label():
		# Sets the label's text.
		var s = object.name + "/" + property + " : "
		var p = object.get_indexed(property)
		match display:
			"":
				s += str(p)
			"length":
				s += num_format % p.length()
			"round":
				match typeof(p):
					TYPE_INT, TYPE_FLOAT:
						s += num_format % p
					TYPE_VECTOR2, TYPE_VECTOR3:
						s += str(p.round())
		label_ref.text = s

var props = []  # An array of the tracked properties.

func _ready():
	if not InputMap.has_action("toggle_debug"):
		InputMap.add_action("toggle_debug")
		var ev = InputEventKey.new()
		ev.keycode = KEY_L
		InputMap.action_add_event("toggle_debug", ev)

func _input(event):
	if event.is_action_pressed("toggle_debug"):
		for n in get_children():
			n.visible = not n.visible

func _process(_delta):
	if not visible:
		return
	for prop in props:
		prop.set_label()

func add_property(object, property, display):
	var label = Label.new()
	label.set("theme_override_fonts/font", load("res://assets/fonts/roboto_mono_medium20.tres"))
	$VBoxContainer.add_child(label)
	props.append(Property.new(object, property, label, display))

func remove_property(object, property):
	for prop in props:
		if prop.object == object and prop.property == property:
			props.erase(prop)
