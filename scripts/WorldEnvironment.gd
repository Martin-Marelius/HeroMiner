extends WorldEnvironment


var env


# Called when the node enters the scene tree for the first time.
func _ready():
	self.env = self.environment
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.depth <= 2:
		env.glow_intensity = lerp(env.glow_intensity, 0.0, 0.01)
	if Global.depth >= 30:
		env.glow_intensity = lerp(env.glow_intensity, 0.9, 0.001)
	
	pass
