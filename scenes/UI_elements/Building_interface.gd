extends PopupPanel

# x location of where the interface is able to be accessed
var location_x
var location_x2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# player input, close and open popup
	player_input()
	

func player_input():
	
	if Global.player_vpos.x > location_x and Global.player_vpos.x < location_x2 and Global.player_vpos.y <= 1:
		if Input.is_action_pressed("enter_building"):
			self.popup()
		if Input.is_action_pressed("exit_building"):
			self.hide()
