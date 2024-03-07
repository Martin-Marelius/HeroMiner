extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	if Global.depth >= 70:
		self.modulate.a = lerp(self.modulate.a, 100/70, 0.1)
	else: 
		self.modulate.a = lerp(self.modulate.a, Global.depth/70, 0.1)
	
