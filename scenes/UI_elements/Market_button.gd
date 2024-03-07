extends Button

var marketprice = Global.marketprice

# Called when the node enters the scene tree for the first time.
func _ready():
	var button = Button.new()
	button.text = "Sell all"
	self.connect("pressed", self, "_button_pressed")
	add_child(self)

# sell all ore in inventory for cash.
func _button_pressed():
	var cash : int = 0
	
	for minerals in Global.inventory:
		cash += (Global.inventory[minerals] * Global.marketprice[minerals])
	
	Global.furnace_on = true
	Global.cash += cash
	Global.inventory.clear()
	print("Sold all minerals!")
