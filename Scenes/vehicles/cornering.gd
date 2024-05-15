extends Node2D

func apply_cornering_force(direction, max_value, pos):
	var slip_angle = $"..".dynamics_state.slip_angle;
	var force_multiplier = abs(max_value * sin(slip_angle))
	var cornering_force: Vector2 = (direction - pos).normalized() * force_multiplier
	$"../..".apply_central_force(cornering_force)
