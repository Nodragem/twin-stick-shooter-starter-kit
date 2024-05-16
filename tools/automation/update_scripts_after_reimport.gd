@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	for node in get_all_children(get_scene()):
		if node is not Node3D:
			continue
		print("resetting scripts for:", node.name,
		 "custom value: ", node.property_can_revert("script"))
		#node.script = node.property_get_revert("script") 
		# WARNING: that does not work, I had to use VS code to remove all the script == null
		print("> done!")

func get_all_children(in_node, children_acc = []):
	children_acc.push_back(in_node)
	for child in in_node.get_children():
		children_acc = get_all_children(child, children_acc)

	return children_acc


