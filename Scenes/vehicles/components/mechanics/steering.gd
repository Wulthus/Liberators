extends Node2D

func turn(direction):
	match direction:
		"left":
			$"../../dynamics/torque".torque("left");
		"right":
			$"../../dynamics/torque".torque("right");
		_:
			print("lol");
