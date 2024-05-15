extends Node2D

#-----------------------------------------------------------STATE & INITIALIZATION

var props = {
	"engine_power": 150.0,
	"brake_power": 150.0,
	"mass_factor": 2.5,
	"torque": 3.0,
	"inertia_factor": 2.5,
	"cornering_force_factor": 2000.0,
	"rolling_resistance": 3.0,
	
	"max_speed": 216.0,
}

var state = {
	"gear": "forward",
	"throttle_applied": false,
	"brakes_applied": false,
	"velocity": Vector2(0, 0),
	"angular_velocity": 0,
	"stopped": true,
	"slip_angle": 0.0,
	"env_static_resistance_factor": 0.03,
	"env_dynamic_resistance_factor": 0.25,
	"audio_revups_count": 0,
	"audio_revdowns_count": 1,
}

func _ready():
	$RigidBody2D.set_mass(props.mass_factor)
	$RigidBody2D.set_inertia(props.inertia_factor)
	$RigidBody2D.set_center_of_mass_mode(1)
	$RigidBody2D.set_center_of_mass($RigidBody2D/Markers/center_of_gravity.position)

#-----------------------------------------------------------SETTERS/GETTERS




func _physics_process(_delta):
#-----------------------------------------------------------MOVEMENT

	var vehicle_position: Vector2 = $RigidBody2D.global_position
	var forward_vector: Vector2 = $"RigidBody2D/Markers/forward_velocity-Vector".global_position
	var reverse_vector: Vector2 = $RigidBody2D/Markers/reverse_velocity_vector.global_position
	var left_vector: Vector2 = $RigidBody2D/Markers/left_cornering_force_vector.global_position
	var right_vector: Vector2 = $RigidBody2D/Markers/right_cornnering_force_vector.global_position
	state.angular_velocity =  $RigidBody2D.get_angular_velocity()
	update_velocity()
	
#----------------------------------------------------------DETECTING STOPPED
	if (
	state.velocity.x < 2.0 && 
	state.velocity.x > -2.0 && 
	state.velocity.y < 2.0 && 
	state.velocity.y > -2.0 &&
	state.angular_velocity != 0
	):
		state.stopped = true
	else:
		state.stopped = false
			
#-------------------------------------------------SLIP ANGLE AND CORNERING FORCE
	if state.stopped == false:
		state.slip_angle = (forward_vector - vehicle_position).angle_to(state.velocity)
	else:
		state.slip_angle = int(0.0)
	
	if state.stopped == false:
		if (
			state.slip_angle < 0.0 &&
			state.slip_angle > -3.14
			):
			cornering(right_vector, state.slip_angle, props.cornering_force_factor, vehicle_position)
		elif (
			state.slip_angle > 0.0 &&
			state.slip_angle < 3.14			
			):
			cornering(left_vector, state.slip_angle, props.cornering_force_factor, vehicle_position)
		
#-----------------------------------------------------SHIFTING GEARS
	
	if Input.is_action_pressed("forward_gear"):
		state.gear = "forward"
		$RigidBody2D/Sounds/forward_gear.play()
	
	if Input.is_action_pressed("reverse_gear"):
		state.gear = "reverse"
		$RigidBody2D/Sounds/reverse_gear.play()
			
#-----------------------------------------------------ACCELERATION AND BRAKES
	
	

#-----------------------------------------------------STEERING
	
	if Input.is_action_pressed("right_turn"):
		$RigidBody2D.apply_torque(props.torque)
		if (state.stopped == true):
			state.throttle_applied = true
		else:
			apply_brakes("half")

	if Input.is_action_pressed("left_turn"):
		$RigidBody2D.apply_torque(-props.torque)
		if (state.stopped == true):
			state.throttle_applied = true
		else:
			apply_brakes("half")
		
	if (
		Input.is_action_just_released("right_turn") ||
		Input.is_action_just_released("left_turn")
		):
		if (state.stopped == true):
			state.throttle_applied = false
		else:
			state.brakes_applied = false
#----------------------------------------------------------TORQUE
		
	if state.angular_velocity > 0 && Input.is_action_pressed("right_turn") == false:
		$RigidBody2D.apply_torque(-props.rolling_resistance)
	
	if state.angular_velocity < 0 && Input.is_action_pressed("left_turn") == false:
		$RigidBody2D.apply_torque(props.rolling_resistance)
		
#-----------------------------------------------------RESISTANCE
		
	if state.stopped == false:
		var factor = abs((state.env_dynamic_resistance_factor)*sin(state.slip_angle))+state.env_static_resistance_factor
		update_velocity()
		resistance(state.velocity, factor)
		update_velocity()

#----------------------------------------------------SOUNDS

	if state.throttle_applied == false:
		$RigidBody2D/Sounds/engine_revup.stop()
		$RigidBody2D/Sounds/engine_revloop.stop()
		state.audio_revups_count = 0
		if (
			$RigidBody2D/Sounds/engine_revdown.is_playing() == false && 
			state.audio_revdowns_count == 0
		):
			$RigidBody2D/Sounds/engine_revdown.play()
			state.audio_revdowns_count = 1
		if $RigidBody2D/Sounds/engine_idle.playing == false:
			$RigidBody2D/Sounds/engine_idle.play()

	if (state.throttle_applied == true):
		$RigidBody2D/Sounds/engine_idle.stop()
		$RigidBody2D/Sounds/engine_revdown.stop()
		state.audio_revdowns_count = 0
		if (
			$RigidBody2D/Sounds/engine_revup.is_playing() == false &&
			state.audio_revups_count == 0
			):
			$RigidBody2D/Sounds/engine_revup.play()
			state.audio_revups_count = 1
		if (
			$RigidBody2D/Sounds/engine_revloop.is_playing() == false
			):
			$RigidBody2D/Sounds/engine_revloop.play()

	if state.brakes_applied == true && state.stopped != true:
		if $RigidBody2D/Sounds/brakes.playing != true:
			$RigidBody2D/Sounds/brakes.play()
	else:
		$RigidBody2D/Sounds/brakes.stop()

	if state.stopped == false:
		if $RigidBody2D/Sounds/tracks.playing == false:
			$RigidBody2D/Sounds/tracks.play()
	else:
		$RigidBody2D/Sounds/tracks.stop()
		
	$RigidBody2D/Sounds/tracks.set_pitch_scale(
		0.7 + ((state.velocity.length() / props.max_speed)*0.5)
	)
	$RigidBody2D/Sounds/tracks.set_volume_db(
		-10.0 + ((state.velocity.length() / props.max_speed)*10)
	)
		
#---------------------------------------------------DYNAMICS FUNCTIONS

func update_velocity():
	state.velocity = $RigidBody2D.get_linear_velocity()
		
func accelerate(direction, pos, factor):
	var acceleration_vector = ((direction - pos).normalized()) * factor
	$RigidBody2D.apply_central_force(acceleration_vector)
	
func brake(vector, factor):
	if state.stopped == false:
		$RigidBody2D.apply_central_force((vector.normalized()) * factor)
		
func resistance(velocity, factor):
	var force_multiplyer = ((1.0+factor)**(abs(velocity.x) + abs(velocity.y)))-1
	var resistance_vector = (-velocity.normalized() * force_multiplyer) * factor
	$RigidBody2D.apply_central_force(resistance_vector)
		
func cornering(direction, slip_angle, max_value, pos):
	var slip_angle_rad = slip_angle
	var force_multiplier = abs(max_value * sin(slip_angle_rad))
	var cornering_force: Vector2 = (direction - pos).normalized() * force_multiplier
	$RigidBody2D.apply_central_force(cornering_force)
	
func apply_brakes(force = "full"):
	state.brakes_applied = true
	match force:
		"full":
			$RigidBody2D/Sounds/brakes.set_pitch_scale(0.4)
			$RigidBody2D/Sounds/brakes.set_volume_db(-16.0)
		"half":
			$RigidBody2D/Sounds/brakes.set_pitch_scale(0.2)
			$RigidBody2D/Sounds/brakes.set_volume_db(-20.0)
		_:
			print("ERROR: apply_brakes function match statement did not recognise following force: ", force)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

