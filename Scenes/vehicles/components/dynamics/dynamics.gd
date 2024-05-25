extends Node2D

var dynamics_props = GameConstants.vehicle_props.dynamics

var dynamics_state = {
	"velocity": Vector2(0, 0),
	"velocity_length": 0.0,
	"stopped": true,
	"slip_angle": 0.0,
	"angular_velocity": 0,
	"env_static_resistance_factor": 0.03,
	"env_dynamic_resistance_factor": 0.25,
}

#----------------------------------------------------------METHODS

func check_velocity():
	dynamics_state.velocity = $"..".get_linear_velocity();
	dynamics_state.velocity_length = dynamics_state.velocity.length()
	
func check_stopped():
	if (dynamics_state.velocity.length() < 2.0):
		dynamics_state.stopped = true;
	else:
		dynamics_state.stopped = false;

func check_slip_angle(forward_vector, vehicle_position):
	if dynamics_state.stopped == false:
		dynamics_state.slip_angle = (forward_vector - vehicle_position).angle_to(dynamics_state.velocity)
	else:
		dynamics_state.slip_angle = int(0.0)
		
func check_angular_velocity():
	dynamics_state.angular_velocity = $"..".get_angular_velocity()

func _physics_process(delta):
	
	#-----------------------------------------------------------GET GLOBAL VECTORS
	
	var vehicle_position: Vector2 = $"..".global_position
	var forward_vector: Vector2 = $"../markers/forward_velocity_vector".global_position
	var reverse_vector: Vector2 = $"../markers/reverse_velocity_vector".global_position
	var left_vector: Vector2 = $"../markers/left_cornering_force_vector".global_position
	var right_vector: Vector2 = $"../markers/right_cornnering_force_vector".global_position
	
	#-----------------------------------------------------------UPDATE STATE
	
	print(dynamics_state)
	
	check_velocity();
	check_stopped();
	check_slip_angle(forward_vector, vehicle_position);
	check_angular_velocity();
	
	#-----------------------------------------------------------APPLY PASSIVE FORCES
	
	$resistance.apply_resistance();
	$cornering.apply_cornering_force(vehicle_position);
	






