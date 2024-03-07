extends "res://scenes/UI_elements/Big_popup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var label1 = $Items/HBoxContainer/Control/TouchScreenButton/Label
onready var label2 = $Items/HBoxContainer/Control2/TouchScreenButton2/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("enter_mineral_processor", self, "open_shop")
	GlobalSignals.connect("exit_mineral_processor", self, "close_shop")


func open_shop():
	_start_tween()
	update_label_values()

func close_shop():
	if self.is_showing:
		_close_tween()
	else:
		pass

func update_label_values():
	var value = 0
	for i in Global.inventory:
		value += i
