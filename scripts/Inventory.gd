extends TextureProgress

onready var label = $Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var minerals = Global.get_inventory_amount()
	label.text = "%s" % minerals + " / " + "%s" % Stats.max_cargo
	
	self.value = minerals * (Stats.max_cargo / 1)
	pass
