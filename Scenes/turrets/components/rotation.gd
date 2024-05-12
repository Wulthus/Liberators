extends Node2D

func _process(_delta):
	var cursor_position = get_global_mouse_position()
	var angle = $"..".get_angle_to(cursor_position)
	var angle_absolute = abs(angle)
	var turret_rotation = $"..".get_global_rotation()
	
	if (
		3.14 > angle_absolute && 
		 angle_absolute > $"../props".props.minimum_angle
		):
		var rate =  $"../props".props.turn_rate if angle > 0 else -$"../props".props.turn_rate
		$"..".set_global_rotation(turret_rotation + rate)
		$"../sounds".play_rotation_sound()
	else:
		$"../sounds".play_stop_sound()
		
#-------------------------------------------------------- SETTERS GETTERS

func add_all_weapons():
	$"../weapons".add_weapons($"../props".props.name, $"../props".props.weapon_path)
