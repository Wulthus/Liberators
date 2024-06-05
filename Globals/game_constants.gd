extends Node

var vehicle_props = {
	"dynamics" = {
		"minimum_velocity" = 2.0,
	}

}

var vehicle_specs = {
	"tank" = {
		"mass_kg": 55000,
		"inertia_factor": 2.5,
		
		"engine_power": 3000000.0,
		"brake_power": 2750000.0,
		"torque": 4.0,

		"rolling_resistance": 5.0,
		"cornering_force_factor": 3000000.0,
		"static_resistance_factor": 0.03,
		"dynamic_resistance_factor": 0.25,
	
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
