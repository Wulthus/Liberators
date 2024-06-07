extends Node2D

func torque(direction):
	match direction:
		"left":
			$"../..".apply_torque(-$"../../specs".specs.torque)
		"right":
			$"../..".apply_torque($"../../specs".specs.torque)
		_:
			print("ERROR: torque match statement did not recognise following input: ", direction)

