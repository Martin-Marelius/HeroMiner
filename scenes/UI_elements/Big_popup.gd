extends Sprite

onready var tween = $Tween

var is_showing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _start_tween():
	if !is_showing:
		tween.interpolate_property(self, 
		"position", 
		Vector2(0,0),
		Vector2(0, -1650),
		0.2,
		Tween.EASE_OUT, 
		Tween.EASE_OUT)
		tween.start()
		is_showing = true
	else:
		pass

func _close_tween():
	tween.interpolate_property(self, 
	"position", 
	Vector2(0,-1650),
	Vector2(0, 0),
	0.2,
	Tween.EASE_OUT, 
	Tween.EASE_OUT)
	tween.start()
	is_showing = false

func _on_Boost_button_pressed():
	self._start_tween()

func _on_Exit_button_pressed():
	self._close_tween()

