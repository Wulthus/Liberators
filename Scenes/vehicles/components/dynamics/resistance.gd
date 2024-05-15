extends Node2D

func apply_resistance():
	if $"..".dynamics_state.stopped == false:
		
		var dynamic_component = $"..".dynamics_state.env_dynamic_resistance_factor;
		var static_component = $"..".dynamics_state.env_static_resistance_factor;
		var slip_angle = $"..".dynamics_state.slip_angle
		var velocity = $"..".dynamics_state.velocity
		
		var calculated_factor = abs((dynamic_component)*sin(slip_angle))+static_component
		var force_multiplyer = ((1.0+calculated_factor)**(abs(velocity.x) + abs(velocity.y)))-1
		var resistance_vector = (-velocity.normalized() * force_multiplyer) * calculated_factor
		
		$"../..".apply_central_force(resistance_vector)

#func apply_resistance(velocity, factor):
#	if $"..".dynamics_state.stopped == false:
#		var force_multiplyer = ((1.0+factor)**(abs(velocity.x) + abs(velocity.y)))-1
#		var resistance_vector = (-velocity.normalized() * force_multiplyer) * factor
#		$"../..".apply_central_force(resistance_vector)
