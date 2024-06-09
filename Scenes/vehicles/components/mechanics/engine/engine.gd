extends Node2D

signal throttle_applied;
signal throttle_released;

func apply_throttle():
	$"..".mechanics_state.throttle_applied = true;
	var gear = $"..".mechanics_state.gear;
	var engine_power = $"../../specs".specs.engine_power
	match gear:
		"forward":
			var direction = $"../../markers/forward_velocity_vector".global_position
			$"../../dynamics/acceleration".accelerate(direction, engine_power)
		"reverse":
			var direction = $"../../markers/reverse_velocity_vector".global_position
			$"../../dynamics/acceleration".accelerate(direction, engine_power)
		_:
			print("Error: engine node match statement did not recognise following gear setting: ", gear)
	throttle_applied.emit();
		

func release_throttle():
	$"..".mechanics_state.throttle_applied = false;
	throttle_released.emit()
