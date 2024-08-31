@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	# Make sure we don't have any paid assets or pieces of furniture
	var save_path:String = "res://assets/kits/meshlib_prototype_bits.tres"
	var mesh_library : MeshLibrary = load(save_path)
	print(mesh_library.resource_name)
	var names_to_delete:Array[String] = [
		"Gun_Rifle","Gun_Pistol","Gun_Sniper","Locker","Locker_Decorated",
		"Weaponrack","Weaponrack_Decorated","Workbench","Workbench_Decorated",
		"Bullet","Bat","Ammo_Box","Ammo_Magazine",
		"table_medium","table_medium_Decorated","table_medium_long",
		"target","target_pieces_A","target_pieces_B","target_pieces_C",
		"Barrel_A","Barrel_B","Barrel_C","Dummy_Base","Pallet_Small_Decorated_B",
		"Pallet_Small_Decorated_A","Pallet_Small","Coin_C","Coin_B","Coin_A",
		"Can_B","Can_A","Box_C","Box_B","Box_A","target_wall_small",
		"target_stand_B","target_stand_A_Decorated","target_stand_A",
		"target_small","target_pieces_F","target_pieces_E","target_pieces_D",
		"target_pieces_C","target_pieces_B","target_pieces_A","Box_A"
	]
	var item_ids = mesh_library.get_item_list()
	var current_name:String = ""
	for id in item_ids:
		current_name = mesh_library.get_item_name(id)
		if names_to_delete.has(current_name):
			mesh_library.remove_item(id)
			print("Deleting: " + current_name)
			names_to_delete.erase(current_name)
	
	print("Remaing items not found: ")
	print(names_to_delete)
	

	
	
	#ResourceSaver.save(mesh_library,ve_path)
