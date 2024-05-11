extends Node2D

var props = GameConstants.turret_props.offensive_turret;

var state = {
	"stop_sound_counter" = 0,
}

func _process(_delta):
	var cursor_position = get_global_mouse_position()
	var angle = $".".get_angle_to(cursor_position)
	var angle_absolute = abs(angle)
	var turret_rotation = $".".get_global_rotation()
	
	if (
		3.14 > angle_absolute && 
		 angle_absolute > props.minimum_angle
		):
		var rate =  props.turn_rate if angle > 0 else -props.turn_rate
		$".".set_global_rotation(turret_rotation + rate)
		play_rotation_sound()
	else:
		play_stop_sound()
		
	if Input.is_action_pressed("fire_left"):
		var left_weapon = $left_barrel/weapon_slot.get_node("weapon")
		left_weapon.fire()
		
	if Input.is_action_pressed("fire_right"):
		var right_weapon = $right_barrel/weapon_slot.get_node("weapon")
		right_weapon.fire()

#------------------------------------------------------------ AUDIO FUNCTIONS

func play_rotation_sound():
	if(
		$sounds/turret_heavy_loop.is_playing() == false
		):
		state.stop_sound_counter = 0
		$sounds/turret_heavy_loop.play()
		
func play_stop_sound():
	var playback_position = $sounds/turret_heavy_loop.get_playback_position()
	if (playback_position >= props.audio.min_sound_length):
		$sounds/turret_heavy_loop.stop()
	if (
		$sounds/turret_heavy_stopped.is_playing() == false && 
		state.stop_sound_counter == 0 
		):
		$sounds/turret_heavy_stopped.play()
		state.stop_sound_counter = 1
		
#------------------------------------------------------------ HELPER FUNCTIONS

func add_weapons():
	var weapons = VehicleConfiguration.get_weapons(props.name);
	
	var left_weapon_present = $left_barrel/weapon_slot.get_child_count() > 0;
	var right_weapon_present = $right_barrel/weapon_slot.get_child_count() > 0;
	
	if (!left_weapon_present):
		var left_weapon_path = props.weapon_path.format({"weapon": weapons.left})
		var left_weapon = load(left_weapon_path).instantiate();
		$left_barrel/weapon_slot.add_child(left_weapon);
		left_weapon.position = $left_barrel/left_barrel_pos.position

	if (!right_weapon_present):
		var right_weapon_path = props.weapon_path.format({"weapon": weapons.right})
		var right_weapon = load(right_weapon_path).instantiate();
		$right_barrel/weapon_slot.add_child(right_weapon);
		right_weapon.position = $right_barrel/right_barrel_pos.position
