extends Node2D

var mechanics_state = {
	"throttle_applied" = false,
	"brakes_applied" = false,
	"gear" = "forward",
}

func _physics_process(delta):
	
	#------------------------------------------------MOVEMENT INPUTS
	
	print(mechanics_state);
	
	if Input.is_action_pressed("forward"):
		match mechanics_state.gear:
			"forward":
				$engine.apply_throttle();
#				accelerate(forward_vector, vehicle_position, props.engine_power)
			"reverse":
				$brakes.apply_brakes()
#				brake(-state.velocity, props.brake_power)
			_:
				print("Error: tank_chasis forward movement match statement did not recognise following gear setting: ", mechanics_state.gear)
				
	if Input.is_action_just_released("forward"):
		match mechanics_state.gear:
			"forward":
				$engine.release_throttle();
			"reverse":
				$brakes.release_brakes();
			_:
				print("Error: tank_chasis forward movement match statement did not recognise following gear setting: ", mechanics_state.gear)
			
	if Input.is_action_pressed("reverse"):
		match mechanics_state.gear:
			"forward":
				$brakes.apply_brakes();
#				apply_brakes("full")
#				$RigidBody2D/Sounds/brakes.set_pitch_scale(0.4)
#				update_velocity()
#				brake(-state.velocity, props.brake_power)
			"reverse":
				$engine.apply_throttle();
#				state.throttle_applied = true
#				accelerate(reverse_vector, vehicle_position, props.engine_power)
			_:
				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", mechanics_state.gear)
	
	if Input.is_action_just_released("reverse"):
		match mechanics_state.gear:
			"forward":
				$brakes.release_brakes();
#				state.brakes_applied = false
			"reverse":
				$engine.release_throttle();
#				state.throttle_applied = false
			_:
				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", mechanics_state.gear)	
				
	if Input.is_action_pressed("left_turn"):
		$steering.turn("left")
	if Input.is_action_pressed("right_turn"):
		$steering.turn("right")
				

	#------------------------------------------------SHIFTING GEARS

	if Input.is_action_pressed("forward_gear"):
		$gearbox.change_gear("forward");
#		$RigidBody2D/Sounds/forward_gear.play()
	
	if Input.is_action_pressed("reverse_gear"):
		$gearbox.change_gear("reverse");
#		$RigidBody2D/Sounds/reverse_gear.play()	
