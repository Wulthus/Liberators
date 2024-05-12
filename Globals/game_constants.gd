extends Node

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
