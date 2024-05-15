extends Node2D

func get_turret_position(type):
	match type:
		"offensive":
			return $offensive_turret_pos.position
		"defensive":
			return $defensive_turret_pos.position
		_:
			print("ERROR. get_turret_position match statement did not cebognise following type: ", type)
