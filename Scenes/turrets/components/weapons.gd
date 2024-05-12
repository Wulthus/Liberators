extends Node2D

func process(_delta):
	if Input.is_action_pressed("fire_left"):
		var left_weapon = $left_barrel/weapon_slot.get_node("weapon")
		left_weapon.fire()
		
	if Input.is_action_pressed("fire_right"):
		var right_weapon = $right_barrel/weapon_slot.get_node("weapon")
		right_weapon.fire()

#---------------------------------------------------------------------HELPER FUNCTIONS

func add_weapons():
	var weapons = VehicleConfiguration.get_weapons($"../props".props.name);
	
	var left_weapon_present = $left_barrel/weapon_slot.get_child_count() > 0;
	var right_weapon_present = $right_barrel/weapon_slot.get_child_count() > 0;
	
	if (!left_weapon_present):
		var left_weapon_path = $"../props".props.weapon_path.format({"weapon": weapons.left})
		var left_weapon = load(left_weapon_path).instantiate();
		$left_barrel/weapon_slot.add_child(left_weapon);
		left_weapon.position = $left_barrel/left_barrel_pos.position

	if (!right_weapon_present):
		var right_weapon_path = $"../props".props.weapon_path.format({"weapon": weapons.right})
		var right_weapon = load(right_weapon_path).instantiate();
		$right_barrel/weapon_slot.add_child(right_weapon);
		right_weapon.position = $right_barrel/right_barrel_pos.position
