extends TextureProgress


var max_fuel = 12

# Called when the node enters the scene tree for the first time.
func _ready():
	self.max_fuel = Stats.fuel_tank
	self.max_value = self.max_fuel
	self.value = self.max_fuel
	
var count = 0

# fuel drop temporary TODO add into Player physics process. More movement == more drain 
func _physics_process(delta):
	if count % 6 == 1:
		if Global.current_fuel <= 0:
			pass
		else:
			Global.current_fuel -= 0.01
	
	count += 1

# graphics update of fuel
func _process(delta):
	self.value = Global.current_fuel

