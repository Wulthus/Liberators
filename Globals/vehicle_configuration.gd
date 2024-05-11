extends Node

var chasis_type = "tank_chasis"

var turrets = {
	"offensive_turret" = {
		"left_barrel" = "weapon",
		"right_barrel" = "weapon",
	},
	
	"defensive_turret" = {
		"left_barrel" = "weapon",
		"right_barrel" = "weapon",
	},
}

#------------------------------------SETTERS / GETTERS

func get_chasis_type():
	return chasis_type

func get_weapons(turret_name):
	var barrels = {
		"left" = turrets[turret_name].left_barrel,
		"right" = turrets[turret_name].right_barrel,
	};
	return barrels
