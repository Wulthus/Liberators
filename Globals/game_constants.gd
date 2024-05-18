extends Node

var vehicle_props = {
	"dynamics" = {
		"minimum_velocity" = 2.0,
	}

}

var vehicle_specs = {
	"tank" = {
		"engine_power": 150.0,
		"brake_power": 150.0,
		"mass_factor": 2.5,
		"torque": 3.0,
		"inertia_factor": 2.5,
		"cornering_force_factor": 2000.0,
		"rolling_resistance": 3.0,
	
		"max_speed": 216.0,
	}
}

var turret_props = {
	"offensive_turret" = {
		"name" = "offensive_turret",
		"weapon_path" = "res://Scenes/weapons/{weapon}.tscn",
		"turn_rate" = 0.005,
		"minimum_angle" = 0.2,
		"audio" = {
			"min_sound_length" = 0.2,
		},
		"sprite" = {
			"scale" = 0.8,
		}
	},
	"defensive_turret" = {
		"name" = "defensive_turret",
		"weapon_path" = "res://Scenes/weapons/{weapon}.tscn",
		"turn_rate" = 0.015,
		"minimum_angle" = 0.15,
		"audio" = {
			"min_sound_length" = 0.2,
		},
		"sprite" = {
			"scale" = 0.5,
		}
	},
}
