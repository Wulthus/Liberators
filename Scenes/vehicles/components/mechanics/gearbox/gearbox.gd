extends Node2D

signal forward_gear;
signal reverse_gear;

func change_gear(selected_gear):
	match selected_gear:
		"forward":
			if ($"..".mechanics_state.gear != "forward"):
				forward_gear.emit()
		"reverse":
			if ($"..".mechanics_state.gear != "reverse"):
				reverse_gear.emit()
		_:
			null
	$"..".mechanics_state.gear = selected_gear;
