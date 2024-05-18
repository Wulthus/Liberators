extends Node2D

func accelerate(direction, engine_power):
	var vehicle_position = $"../..".global_position;
	var acceleration_vector = ((direction - vehicle_position).normalized()) * engine_power
	$"../..".apply_central_force(acceleration_vector)
