extends Node2D

func change_gear(selected_gear):
	$"..".mechanics_state.gear = selected_gear;
