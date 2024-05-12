extends Node2D

var state = {
	"stop_sound_counter" = 0,
}

func play_rotation_sound():
	if($turret_loop.is_playing() == false):
		state.stop_sound_counter = 0
		$turret_loop.play()
		
func play_stop_sound():
	var playback_position = $turret_loop.get_playback_position()
	if (playback_position >= $"../props".props.audio.min_sound_length):
		$turret_loop.stop()
	if (
		$turret_stopped.is_playing() == false && 
		state.stop_sound_counter == 0 
		):
		$turret_stopped.play()
		state.stop_sound_counter = 1
