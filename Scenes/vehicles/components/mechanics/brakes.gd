extends Node2D

func apply_brakes():
	var brake_power = $"../../specs".specs.brake_power;
	$"..".mechanics_state.brakes_applied = true
	$"../../dynamics/braking".brake(brake_power);

func release_brakes():
	$"..".mechanics_state.brakes_applied = false
