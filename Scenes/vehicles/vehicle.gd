extends Node2D

#-----------------------------------------------------------STATE & INITIALIZATION


#	if Input.is_action_pressed("forward"):
#		match state.gear:
#			"forward":
#				state.throttle_applied = true
#				accelerate(forward_vector, vehicle_position, props.engine_power)
#				update_velocity()
#			"reverse":
#				apply_brakes("full")
#				update_velocity()
#				brake(-state.velocity, props.brake_power)
#			_:
#				print("Error: tank_chasis forward movement match statement did not recognise following gear setting: ", state.gear)
#
#	if Input.is_action_just_released("forward"):
#		match state.gear:
#			"forward":
#				state.throttle_applied = false
#			"reverse":
#				state.brakes_applied = false
#			_:
#				print("Error: tank_chasis forward movement match statement did not recognise following gear setting: ", state.gear)
#
#	if Input.is_action_pressed("reverse"):
#		match state.gear:
#			"forward":
#				apply_brakes("full")
#				$RigidBody2D/Sounds/brakes.set_pitch_scale(0.4)
#				update_velocity()
#				brake(-state.velocity, props.brake_power)
#			"reverse":
#				state.throttle_applied = true
#				accelerate(reverse_vector, vehicle_position, props.engine_power)
#				update_velocity()
#			_:
#				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", state.gear)
#
#	if Input.is_action_just_released("reverse"):
#		match state.gear:
#			"forward":
#				state.brakes_applied = false
#			"reverse":
#				state.throttle_applied = false
#			_:
#				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", state.gear)		
#}
#
#var state = {
#	"gear": "forward",
#	"throttle_applied": false,
#	"brakes_applied": false,
#
#
#
#	"slip_angle": 0.0,
#	"env_static_resistance_factor": 0.03,
#	"env_dynamic_resistance_factor": 0.25,
#	"audio_revups_count": 0,
#	"audio_revdowns_count": 1,
#}
#
#func _ready():
#	$RigidBody2D.set_mass(props.mass_factor)
#	$RigidBody2D.set_inertia(props.inertia_factor)
#	$RigidBody2D.set_center_of_mass_mode(1)
#	$RigidBody2D.set_center_of_mass($RigidBody2D/Markers/center_of_gravity.position)
#
##-----------------------------------------------------------SETTERS/GETTERS
#
#func get_turret_position(type):
#	match type:
#		"offensive":
#			return $RigidBody2D/Markers/offensive_turret_hardpoint.position
#		"defensive":
#			return $RigidBody2D/Markers/defensive_turret_hardpoint.position
#		_:
#			print("ERROR. get_turret_position match statement did not cebognise following type: ", type)
#
#
#func _physics_process(_delta):
##-----------------------------------------------------------MOVEMENT
#
##	var vehicle_position: Vector2 = $RigidBody2D.global_position
##	var forward_vector: Vector2 = $"RigidBody2D/Markers/forward_velocity-Vector".global_position
##	var reverse_vector: Vector2 = $RigidBody2D/Markers/reverse_velocity_vector.global_position
##	var left_vector: Vector2 = $RigidBody2D/Markers/left_cornering_force_vector.global_position
##	var right_vector: Vector2 = $RigidBody2D/Markers/right_cornnering_force_vector.global_position
##	state.angular_velocity =  $RigidBody2D.get_angular_velocity()
##	update_velocity()
#
##----------------------------------------------------------DETECTING STOPPED
##	if (
##	state.velocity.x < 2.0 && 
##	state.velocity.x > -2.0 && 
##	state.velocity.y < 2.0 && 
##	state.velocity.y > -2.0 &&
##	state.angular_velocity != 0
##	):
##		state.stopped = true
##	else:
##		state.stopped = false
#
##-------------------------------------------------SLIP ANGLE AND CORNERING FORCE
#
##
#
#
##-----------------------------------------------------SHIFTING GEARS
#
#
#
##-----------------------------------------------------ACCELERATION AND BRAKES
#
#	if Input.is_action_pressed("forward"):
#		match state.gear:
#			"forward":
#				state.throttle_applied = true
#				accelerate(forward_vector, vehicle_position, props.engine_power)
#				update_velocity()
#			"reverse":
#				apply_brakes("full")
#				update_velocity()
#				brake(-state.velocity, props.brake_power)
#			_:
#				print("Error: tank_chasis forward movement match statement did not recognise following gear setting: ", state.gear)
#
#	if Input.is_action_just_released("forward"):
#		match state.gear:
#			"forward":
#				state.throttle_applied = false
#			"reverse":
#				state.brakes_applied = false
#			_:
#				print("Error: tank_chasis forward movement match statement did not recognise following gear setting: ", state.gear)
#
#	if Input.is_action_pressed("reverse"):
#		match state.gear:
#			"forward":
#				apply_brakes("full")
#				$RigidBody2D/Sounds/brakes.set_pitch_scale(0.4)
#				update_velocity()
#				brake(-state.velocity, props.brake_power)
#			"reverse":
#				state.throttle_applied = true
#				accelerate(reverse_vector, vehicle_position, props.engine_power)
#				update_velocity()
#			_:
#				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", state.gear)
#
#	if Input.is_action_just_released("reverse"):
#		match state.gear:
#			"forward":
#				state.brakes_applied = false
#			"reverse":
#				state.throttle_applied = false
#			_:
#				print("Error: tank_chasis reverse movement match statement did not recognise following gear setting: ", state.gear)			
#
##-----------------------------------------------------STEERING
#
#	if Input.is_action_pressed("right_turn"):
#		$RigidBody2D.apply_torque(props.torque)
#		if (state.stopped == true):
#			state.throttle_applied = true
#		else:
#			apply_brakes("half")
#
#	if Input.is_action_pressed("left_turn"):
#		$RigidBody2D.apply_torque(-props.torque)
#		if (state.stopped == true):
#			state.throttle_applied = true
#		else:
#			apply_brakes("half")
#
#	if (
#		Input.is_action_just_released("right_turn") ||
#		Input.is_action_just_released("left_turn")
#		):
#		if (state.stopped == true):
#			state.throttle_applied = false
#		else:
#			state.brakes_applied = false
##----------------------------------------------------------TORQUE
#
#	if state.angular_velocity > 0 && Input.is_action_pressed("right_turn") == false:
#		$RigidBody2D.apply_torque(-props.rolling_resistance)
#
#	if state.angular_velocity < 0 && Input.is_action_pressed("left_turn") == false:
#		$RigidBody2D.apply_torque(props.rolling_resistance)
#
#
#
##----------------------------------------------------SOUNDS
#
#	if state.throttle_applied == false:
#		$RigidBody2D/Sounds/engine_revup.stop()
#		$RigidBody2D/Sounds/engine_revloop.stop()
#		state.audio_revups_count = 0
#		if (
#			$RigidBody2D/Sounds/engine_revdown.is_playing() == false && 
#			state.audio_revdowns_count == 0
#		):
#			$RigidBody2D/Sounds/engine_revdown.play()
#			state.audio_revdowns_count = 1
#		if $RigidBody2D/Sounds/engine_idle.playing == false:
#			$RigidBody2D/Sounds/engine_idle.play()
#
#	if (state.throttle_applied == true):
#		$RigidBody2D/Sounds/engine_idle.stop()
#		$RigidBody2D/Sounds/engine_revdown.stop()
#		state.audio_revdowns_count = 0
#		if (
#			$RigidBody2D/Sounds/engine_revup.is_playing() == false &&
#			state.audio_revups_count == 0
#			):
#			$RigidBody2D/Sounds/engine_revup.play()
#			state.audio_revups_count = 1
#		if (
#			$RigidBody2D/Sounds/engine_revloop.is_playing() == false
#			):
#			$RigidBody2D/Sounds/engine_revloop.play()
#
#	if state.brakes_applied == true && state.stopped != true:
#		if $RigidBody2D/Sounds/brakes.playing != true:
#			$RigidBody2D/Sounds/brakes.play()
#	else:
#		$RigidBody2D/Sounds/brakes.stop()
#
#	if state.stopped == false:
#		if $RigidBody2D/Sounds/tracks.playing == false:
#			$RigidBody2D/Sounds/tracks.play()
#	else:
#		$RigidBody2D/Sounds/tracks.stop()
#
#	$RigidBody2D/Sounds/tracks.set_pitch_scale(
#		0.7 + ((state.velocity.length() / props.max_speed)*0.5)
#	)
#	$RigidBody2D/Sounds/tracks.set_volume_db(
#		-10.0 + ((state.velocity.length() / props.max_speed)*10)
#	)
#
##---------------------------------------------------DYNAMICS FUNCTIONS
#
#
#
#
#
#
#
#
#
#
#
#func apply_brakes(force = "full"):
#	state.brakes_applied = true
#	match force:
#		"full":
#			$RigidBody2D/Sounds/brakes.set_pitch_scale(0.4)
#			$RigidBody2D/Sounds/brakes.set_volume_db(-16.0)
#		"half":
#			$RigidBody2D/Sounds/brakes.set_pitch_scale(0.2)
#			$RigidBody2D/Sounds/brakes.set_volume_db(-20.0)
#		_:
#			print("ERROR: apply_brakes function match statement did not recognise following force: ", force)
#
##-------------------------------------------------------SETTERS GETTERS

	
	
	
	
	
	
	
	
	
	
	
	
	

