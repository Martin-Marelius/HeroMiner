extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# todo
func _on_sell():
	pass

var val = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if val != Global.cash:
		self.text = "%s" % Global.cash
		val = Global.cash
	
	
