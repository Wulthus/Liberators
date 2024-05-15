extends Node2D

func brake(vector, factor):
	if $"..".dynamics_state.stopped == false:
		$"../..".apply_central_force((vector.normalized()) * factor)
