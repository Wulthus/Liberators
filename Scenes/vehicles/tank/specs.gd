extends Node2D

var specs = GameConstants.vehicle_specs.tank

func _ready():
	$"..".set_mass(specs.mass_kg)
#	$"..".set_inertia(specs.inertia_factor)
#	$"..".set_center_of_mass_mode(1)
#	$"..".set_center_of_mass($RigidBody2D/Markers/center_of_gravity.position)
