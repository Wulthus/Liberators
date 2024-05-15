extends Node2D

func accelerate(direction, pos, factor):
	var acceleration_vector = ((direction - pos).normalized()) * factor
	$"../..".apply_central_force(acceleration_vector)
