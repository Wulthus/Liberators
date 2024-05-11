extends Node2D

var test_peer = ENetMultiplayerPeer.new()
#var vehicle_scene = preload("res://Scenes/vehicles/tank_chasis.tscn")
@export var player_scene: PackedScene

var player_vehicle_name = "player_vehicle"
var vehicle_path_string = "res://Scenes/vehicles/{vehicle}.tscn"

func _on_host_button_pressed():
	test_peer.create_server(135)
	multiplayer.multiplayer_peer = test_peer
	multiplayer.peer_connected.connect(add_vehicle)
	add_vehicle(player_vehicle_name)
	
	
func add_vehicle(id = 1):
	var vehicle_type = VehicleConfiguration.get_chasis_type()
	var vehicle_path = vehicle_path_string.format({"vehicle": vehicle_type})
	var vehicle_scene = load(vehicle_path)
	var new_vehicle = vehicle_scene.instantiate()
	new_vehicle.name = str(id)
	call_deferred("add_child", new_vehicle)
	call_deferred("add_turrets")

	
func add_turrets():
	var vehicle = get_node(player_vehicle_name)
	var vehicle_body = vehicle.get_node("RigidBody2D")

	var offensive_turret_scene = preload("res://Scenes/turrets/off_turret.tscn");
	var defensive_turret_scene = preload("res://Scenes/turrets/defensive_turret.tscn");

	var def_turr_pos = vehicle.get_turret_position("defensive")
	var off_turr_pos = vehicle.get_turret_position("offensive")

	var offensive_turret = offensive_turret_scene.instantiate();
	var defensive_turret = defensive_turret_scene.instantiate();

	vehicle_body.add_child(offensive_turret);
	offensive_turret.position = off_turr_pos
	offensive_turret.add_weapons();
	vehicle_body.add_child(defensive_turret);
	defensive_turret.position = def_turr_pos

#func add_character(id = 1):
#	var new_player = player_scene.instantiate()
#	new_player.name = str(id)
#	call_deferred("add_child", new_player)


func _on_join_button_pressed():
	test_peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = test_peer
