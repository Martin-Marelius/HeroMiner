extends Node2D


signal mineral_found


signal enter_mineral_processor
signal exit_mineral_processor

signal enter_fuel_station
signal exit_fuel_station

signal enter_bank
signal exit_bank

signal enter_workshop
signal exit_workshop

signal enter_item_shop
signal exit_item_shop


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_mineral_found():
	emit_signal("mineral_found")

func _on_building_enter(id):
	if id == 1:
		emit_signal("enter_mineral_processor")
	if id == 2:
		emit_signal("enter_fuel_station")
	if id == 3:
		emit_signal("enter_bank")
	if id == 4:
		emit_signal("enter_workshop")
	if id == 5:
		emit_signal("enter_item_shop")
	pass

func _on_building_exit(id):
	if id == 1:
		emit_signal("exit_mineral_processor")
	if id == 2:
		emit_signal("exit_fuel_station")
	if id == 3:
		emit_signal("exit_bank")
	if id == 4:
		emit_signal("exit_workshop")
	if id == 5:
		emit_signal("exit_item_shop")
	pass
