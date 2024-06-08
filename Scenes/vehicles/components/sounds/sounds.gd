extends Node2D

var audio_state = {
	"play_idle": true,
	"play_running": false,
	"revved_up": false,
	"revved_down": false,
}

#------------------------------------------------------------------------LOOPING SOUNDS

func _process(_delta):
	
	print (audio_state);
	
	if (audio_state.play_idle == true && $engine_idle.playing == false):
		$engine_revloop.stop();
		$engine_idle.play();
	
	if (audio_state.play_running == true && $engine_revloop.playing == false):
		$engine_idle.stop();
		$engine_revloop.play()
		
#------------------------------------------------------------------------GEARBOX SOUNDS

func _on_gearbox_forward_gear():
	if ($"../mechanics".mechanics_state.gear != "forward"):
		$forward_gear.play()


func _on_gearbox_reverse_gear():
	if ($"../mechanics".mechanics_state.gear != "reverse"):
		$reverse_gear.play()

#------------------------------------------------------------------------THROTTLE APPLIED/RELEASED

func _on_engine_throtte_applied():
	audio_state.play_running = true;
	audio_state.play_idle = false;
	if (audio_state.revved_up == false):
		$engine_revup.play()
		$engine_revdown.stop()
		audio_state.revved_up = true
		audio_state.revved_down = false

func _on_engine_throttle_released():
	audio_state.play_running = false;
	audio_state.play_idle = true;
	if (audio_state.revved_down == false):
		$engine_revup.stop();
		$engine_revdown.play();
		audio_state.revved_down = true;
		audio_state.revved_up = false;


#------------------------------------------------------------------------BRAKES

func _on_brakes_brakes_applied():
	if ($brakes.playing == false):
		$brakes.play();


func _on_brakes_brakes_released():
	if ($brakes.playing == true):
		$brakes.stop();
