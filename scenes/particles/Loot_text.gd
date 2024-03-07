extends Node2D


var FCT = preload("res://scenes/particles/FCT.tscn")

export var travel = Vector2(0, -240)
export var duration = 1.2
export var spread = PI/2

func show_value(value):
	var fct = FCT.instance()
	add_child(fct)
	fct.show_value(str(value), travel, duration, spread)
