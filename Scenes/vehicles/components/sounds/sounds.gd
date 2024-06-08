extends Node2D

var audio_state = {
	"play_idle": true,
	"play_running": false,
	"revved_up": false,
	"revved_down": false,
	
}

func _process(_delta):
	
	print (audio_state);
	
	if (audio_state.play_idle == true && $engine_idle.playing == false):
		$engine_revloop.stop();
		$engine_idle.play();
	elif (audio_state.play_running == true && $engine_revloop.playing == false):
		print("I ran");
		$engine_idle.stop();
		$engine_revloop.play()

func _on_gearbox_forward_gear():
	if ($"../mechanics".mechanics_state.gear != "forward"):
		$forward_gear.play()


func _on_gearbox_reverse_gear():
	if ($"../mechanics".mechanics_state.gear != "reverse"):
		$reverse_gear.play()


func _on_engine_throtte_applied():
	audio_state.play_idle = false;
	if (audio_state.revved_up == false && $engine_revup.playing == false):
		$engine_revup.play()
		audio_state.revved_up = true
		audio_state.revved_down = false
		
func _on_engine_revup_finished():
	audio_state.revved_up = true;
	audio_state.play_running = true;


func _on_engine_throttle_released():
	audio_state.play_running = false;
	if (audio_state.revved_down == false && $engine_revdown.playing == false):
		$engine_revdown.play();
		audio_state.revved_up = false;
		audio_state.revved_down = true;

func _on_engine_revdown_finished():
	audio_state.revved_down = true;
	audio_state.play_idle = true;
