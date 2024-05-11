extends Node2D

var props = {
	"turn_rate" = 0.015,
	"minimum_angle" = 0.15,
	"audio" = {
		"min_sound_length" = 0.2,
	},
}

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

#------------------------------------------------------------ AUDIO FUNCTIONS

func play_rotation_sound():
	if(
		$sounds/turret_light_loop.is_playing() == false
		):
		state.stop_sound_counter = 0
		$sounds/turret_light_loop.play()
		
func play_stop_sound():
	var position = $sounds/turret_light_loop.get_playback_position()
	if (position >= props.audio.min_sound_length):
		$sounds/turret_light_loop.stop()
	if (
		$sounds/turret_light_stopped.is_playing() == false && 
		state.stop_sound_counter == 0 
		):
		$sounds/turret_light_stopped.play()
		state.stop_sound_counter = 1
