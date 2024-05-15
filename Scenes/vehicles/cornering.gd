extends Node2D

func apply_cornering_force(vehicle_position):
	if $"..".dynamics_state.stopped == false:
		
		var slip_angle = $"..".dynamics_state.slip_angle;
		var left_vector = $"../../markers/left_cornering_force_vector";
		var right_vector = $"../../markers/right_cornnering_force_vector";
		var cornering_force_factor = $"../../props".props.cornering_force_factor;
		
		if (
			slip_angle < 0.0 &&
			slip_angle > -3.14
			):
			cornering(right_vector, slip_angle, cornering_force_factor, vehicle_position)
		elif (
			slip_angle > 0.0 &&
			slip_angle < 3.14			
			):
			cornering(left_vector, slip_angle, cornering_force_factor, vehicle_position)

func cornering(direction, angle, max_value, pos):
	var force_multiplier = abs(max_value * sin(angle))
	var cornering_force: Vector2 = (direction - pos).normalized() * force_multiplier
	$"../..".apply_central_force(cornering_force)
