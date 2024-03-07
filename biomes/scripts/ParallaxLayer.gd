extends ParallaxLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.depth <= 22:
		get_child(0).modulate.a = 1.0
	if Global.depth > 22:
		self.motion_scale.y = 0.9
	else:
		self.motion_scale.y = 1.0
		
	if Global.depth >= get_parent().get_parent().start_depth and Global.depth <= get_parent().get_parent().end_depth:
		get_child(0).modulate.a = lerp(get_child(0).modulate.a, 1.0, delta*2)
	else:
		get_child(0).modulate.a = lerp(get_child(0).modulate.a, 0.0, delta*1.5)
