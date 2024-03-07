extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var animations = null


# Called when the node enters the scene tree for the first time.
func _ready():
	self.animations = get_children()
	

func _play_animation(anim):
	
	for child in get_children():
		if child.name == anim:
			child.frame = 0
			child.play()
			
	
	
