extends Node2D

func _physics_process(delta):
		if Input.is_action_pressed("forward"):
		match state.gear:
			"forward":
				state.throttle_applied = true
				accelerate(forward_vector, vehicle_position, props.engine_power)
				update_velocity()
			"reverse":
				apply_brakes("full")
				update_velocity()
				brake(-state.velocity, props.brake_power)
			_:
				print("Error: tank_chasis forward movement match statement did not recognise following gear setting: ", state.gear)
				
	if Input.is_action_just_released("forward"):
		match state.gear:
			"forward":
				state.throttle_applied = false
			"reverse":
				state.brakes_applied = false
			_:
				print("Error: tank_chasis forward movement match statement did not recognise following gear setting: ", state.gear)
			
	if Input.is_action_pressed("reverse"):
		match state.gear:
			"forward":
				apply_brakes("full")
				$RigidBody2D/Sounds/brakes.set_pitch_scale(0.4)
				update_velocity()
				brake(-state.velocity, props.brake_power)
			"reverse":
				state.throttle_applied = true
				accelerate(reverse_vector, vehicle_position, props.engine_power)
				update_velocity()
			_:
				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", state.gear)
	
	if Input.is_action_just_released("reverse"):
		match state.gear:
			"forward":
				state.brakes_applied = false
			"reverse":
				state.throttle_applied = false
			_:
				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", state.gear)		
