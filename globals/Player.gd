extends Node

signal update_water_ui(amount)

var max_water := 100
var water:int = 20: set = update_water

func update_water(amount):
	water = clamp(amount, 0, max_water)
	update_water_ui.emit(water)
