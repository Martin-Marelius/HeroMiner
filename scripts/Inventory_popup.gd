extends Node2D

onready var tween = $Tween
onready var vbox = $TextureProgress/ScrollContainer/Button/VBoxContainer
onready var panel_inst = preload("res://scenes/Mineral_panel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("mineral_found", self, "update_inventory")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Open_inventory") && self.position.x <= 20:
		tween.interpolate_property(self, "position", self.position, Vector2(330,-60), 0.5, Tween.TRANS_BACK,Tween.EASE_IN)
		tween.start()

	
	if Input.is_action_just_pressed("Open_inventory") && self.position.x >= 300:
		tween.interpolate_property(self, "position", self.position, Vector2(-170,-60), 0.5, Tween.TRANS_BACK,Tween.EASE_IN)
		tween.start()


func update_inventory():
	var count = 0
	for mineral in Global.inventory:
		var mineral_entry = panel_inst.instance()
		mineral_entry.set_values("", mineral, Global.inventory[mineral])
		mineral_entry.position.y = 110 * count
		vbox.add_child(mineral_entry)
		count += 1
		show()
	pass

func open_inventory():
	var count = 0
	for mineral in Global.inventory:
		var mineral_entry = panel_inst.instance()
		mineral_entry.set_values("", mineral, Global.inventory[mineral])
		mineral_entry.position.y = 110 * count
		vbox.add_child(mineral_entry)
		count += 1
		show()
	pass

func close_inventory():
	pass
