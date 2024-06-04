extends Node2D

func torque(direction):
	match direction:
		"left":
			$"../..".apply_torque(-$"../../specs".specs.torque)
		"right":
			$"../..".apply_torque($"../../specs".specs.torque)
		_:
			print("LOL")

	#if Input.is_action_pressed("right_turn"):
		#$RigidBody2D.apply_torque(props.torque)
		#if (state.stopped == true):
			#state.throttle_applied = true
		#else:
			#apply_brakes("half")
#
	#if Input.is_action_pressed("left_turn"):
		#$RigidBody2D.apply_torque(-props.torque)
		#if (state.stopped == true):
			#state.throttle_applied = true
		#else:
			#apply_brakes("half")
#
	#if (
		#Input.is_action_just_released("right_turn") ||
		#Input.is_action_just_released("left_turn")
		#):
		#if (state.stopped == true):
			#state.throttle_applied = false
		#else:
			#state.brakes_applied = false
##----------------------------------------------------------TORQUE
#

