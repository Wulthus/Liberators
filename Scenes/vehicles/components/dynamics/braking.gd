extends Node2D

func brake(brake_power):
	var direction = $"../..".get_linear_velocity();
	if $"..".dynamics_state.stopped == false:
		$"../..".apply_central_force(-(direction.normalized()) * brake_power)
