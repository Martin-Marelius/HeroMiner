extends Node2D

onready var icon_sprite = $Panel/Icon
onready var title_label = $Panel/Title
onready var amount_label = $Panel/Amount



func add(icon:String, title:String, amount:int):
	self.icon = icon
	self.title = title
	self.amount = amount 

func set_values(icon, title, amount):
	#icon_sprite.texture = icon
	$Panel/Icon.texture = load("res://assets/minerals/minerals_full/%s_full.png" % title.to_lower())
	$Panel/Title.text = title
	$Panel/Amount.text = str(amount)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



