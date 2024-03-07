extends "res://scripts/CanvasModulate.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	
	if Global.depth >= 5:
		var darkness = 1 - (Global.depth / 1000)
		self.set_color(Color(darkness, darkness, darkness, 1 ))
		
	else: 
		self.set_color(Color(1, 1, 1, 1 ))
