extends "res://scenes/buildings/Building.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Global.furnace_on:
		_start_furnace()
		Global.furnace_on = false

func _start_furnace():
	$building/dark.visible = false 
	$building/glow.visible = true 
	$main_smoke.visible = true 
	
	start_timer()
	
func start_timer():
	$Timer.start(15)


func _on_Timer_timeout():
	$building/dark.visible = true 
	$building/glow.visible = false 
	$main_smoke.visible = false
