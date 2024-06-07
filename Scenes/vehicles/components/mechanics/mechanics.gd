extends Node2D

var mechanics_state = {
	"throttle_applied": false,
	"brakes_applied": false,
	"gear": "forward",
}

func _physics_process(_delta):
	
	#------------------------------------------------MOVEMENT INPUTS
	
	print(mechanics_state);
	
	if Input.is_action_pressed("forward"):
		match mechanics_state.gear:
			"forward":
				$engine.apply_throttle();
			"reverse":
				$brakes.apply_brakes()
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
			"reverse":
				$engine.apply_throttle();
			_:
				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", mechanics_state.gear)
	
	if Input.is_action_just_released("reverse"):
		match mechanics_state.gear:
			"forward":
				$brakes.release_brakes();
			"reverse":
				$engine.release_throttle();
			_:
				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", mechanics_state.gear)	
				
	if Input.is_action_pressed("left_turn"):
		$steering.turn("left")
	if Input.is_action_pressed("right_turn"):
		$steering.turn("right")
				

	#------------------------------------------------SHIFTING GEARS

	if Input.is_action_pressed("forward_gear"):
		$gearbox.change_gear("forward");
	
	if Input.is_action_pressed("reverse_gear"):
		$gearbox.change_gear("reverse");
