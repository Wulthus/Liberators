extends Node2D

#----------------------------------------------------------------------------MOVEMENT RESISTANCE

func apply_linear_resistance():
	if $"..".dynamics_state.stopped == false:
		
		var dynamic_component = $"../../specs".specs.dynamic_resistance_factor;
		var static_component = $"../../specs".specs.static_resistance_factor;
		var slip_angle = $"..".dynamics_state.slip_angle
		var velocity = $"..".dynamics_state.velocity
		
		var calculated_factor = abs((dynamic_component)*sin(slip_angle))+static_component
		var force_multiplyer = ((1.0+calculated_factor)**(abs(velocity.x) + abs(velocity.y)))-1
		var resistance_vector = (-velocity.normalized() * force_multiplyer) * calculated_factor
		
		$"../..".apply_central_force(resistance_vector)


#----------------------------------------------------------------------------ROLLING RESISTANCE

func apply_rolling_resistance():
	
	var angular_velocity = $"..".dynamics_state.angular_velocity
	
	if angular_velocity > 0 && Input.is_action_pressed("right_turn") == false:
		$"../..".apply_torque(-$"../../specs".specs.rolling_resistance)

	if angular_velocity < 0 && Input.is_action_pressed("left_turn") == false:
		$"../..".apply_torque($"../../specs".specs.rolling_resistance)
