extends Button

const GAS_PRICE : int = 6

func _ready():
	var button = Button.new()
	button.text = "Click me"
	self.connect("pressed", self, "_button_pressed")
	add_child(self)

func _button_pressed():
	var liter_filled = Stats.fuel_tank - Global.current_fuel
	Global.cash -= liter_filled * GAS_PRICE
	Global.current_fuel = Stats.fuel_tank
	
	print("tank filled!")
