extends Node2D

func turn(direction):
	match direction:
		"left":
			$"../../dynamics/torque".torque("left");
		"right":
			$"../../dynamics/torque".torque("right");
		_:
			print("ERROR: steering match statement did not recognise following direction: ", direction);
