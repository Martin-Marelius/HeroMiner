extends TextureProgress


var max_hull = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_hull = Stats.hull
	self.max_value = self.max_hull
	self.value = max_hull

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
