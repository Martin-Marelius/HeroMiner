extends Node2D

# start and end position for the building in tilemap
var x_start_pos
var x_end_pos

var _texture_inactive = load("res://assets/UI_components/buildings/enter_inactive_green.png")
var _texture_active = load("res://assets/UI_components/buildings/enter_active_green.png")

# id of the building
export var id:int = 0

var in_building : bool = false
var openened : bool = false

onready var tween_values = [Vector2(0,-10), Vector2(0,0)]

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_tween()

func _start_tween():
	$Tween.interpolate_property($Node2D, 
	"position", 
	tween_values[0], 
	tween_values[1], 
	1,
	Tween.EASE_OUT, 
	Tween.EASE_OUT)    
	$Tween.start()

func _on_Area2D_area_entered(area):
	in_building = true
	$Node2D/Enter_button.texture_normal = _texture_active
	$Node2D/Enter_button.visible = true
	$Highlight.visible = true

func _on_Area2D_area_exited(area):
	in_building = false
	if openened:
		GlobalSignals._on_building_exit(self.id)
		openened = false
	$Node2D/Enter_button.texture_normal = _texture_inactive
	$Node2D/Enter_button.visible = false
	$Highlight.visible = false

func _on_Tween_tween_completed(object, key):
	tween_values.invert()
	_start_tween()


func _on_Building_onclick_pressed():
	if self.in_building:
		GlobalSignals._on_building_enter(id)
	else:
		pass
