extends "res://scenes/UI_elements/Building_interface.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var label = $ui_window/Label
onready var button = $ui_window/Button


# Called when the node enters the scene tree for the first time.
func _ready():
	self.location_x = 760
	self.location_x2 = 760 + 270
	pass # Replace with function body.

func player_input():
	
	if Global.player_vpos.x > location_x and Global.player_vpos.x < location_x2 and Global.player_vpos.y <= 1:
		if Input.is_action_pressed("enter_building"):
			var text = ""
			for mineral in Global.inventory:
				text += "%s: " % mineral + "%s\n" % Global.inventory[mineral]
			label.text = text
			self.popup()
		if Input.is_action_pressed("exit_building"):
			label.text = ""
			self.hide()

