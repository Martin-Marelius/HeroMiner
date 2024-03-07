extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.depth <= 5:
		self.zoom = lerp(self.zoom, Vector2(1.15,1.15), 0.01)
	if Global.depth >= 20:
		self.zoom = lerp(self.zoom, Vector2(1,1), 0.001)

