extends Node2D

signal brakes_applied;
signal brakes_released;

func apply_brakes():
	var brake_power = $"../../specs".specs.brake_power;
	$"..".mechanics_state.brakes_applied = true
	$"../../dynamics/braking".brake(brake_power);
	brakes_applied.emit()

func release_brakes():
	$"..".mechanics_state.brakes_applied = false;
	brakes_released.emit()
