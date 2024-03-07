extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func _process(delta):
	self.text = "%s\n" % Global.current_health + "/\n" + "%s" % Stats.hull
