extends ItemList


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var panel_inst = preload("res://scenes/Mineral_panel.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.connect("mineral_found", self, "update_mineral_processor")


func update_mineral_processor():
	var count = 0
	for mineral in Global.inventory:
		var mineral_entry = panel_inst.instance()
		mineral_entry.set_values("", mineral, Global.inventory[mineral])
		mineral_entry.position.y = 110 * count
		self.add_child(mineral_entry)
		count += 1
		show()
