extends "res://scenes/UI_elements/Big_popup.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _ready():
	GlobalSignals.connect("enter_workshop", self, "open_shop")
	GlobalSignals.connect("exit_workshop", self, "close_shop")


func open_shop():
	_start_tween()

func close_shop():
	if self.is_showing:
		_close_tween()
	else:
		pass
