extends Node2D

onready var tilemap = $"/root/GlobalTileMap"
onready var minerals = $Minerals
onready var details = $Details
onready var treasure = $Treasure

# text popup on mining
var fct_instance = null
var FCT = preload("res://scenes/particles/Loot_text.tscn")

# signals
signal found_ore

# fetch dictionary of all mined tiles
onready var mined_tiles = tilemap.mined_tiles

# start depth, biome ends when next biome starts, else is infinite
export var start_depth = 0
export var end_depth = 0

export var tile_id = -1

# dig hardness
export var dig_hardness = 10

export var score = 10

# choose gradient that the 10 first tiles will have
export(Color, RGB) var start_gradient

# if details should be added
export var tile_details = false

# if minerals should be added
export var spawn_minerals = false

# if treasure/fossils should be added
export var spawn_treasure = false

var noise = null

func _ready():
	
	add_market_price()
	generate_noise()
	
	fct_instance = FCT.instance()
	add_child(fct_instance)

func add_market_price():
	for ore in minerals.get_children():
		Global.marketprice[ore.mineralName] = ore.value

func remove_cell(x, y):
	tilemap.set_cell(x, y, -1)
	details.get_child(0).set_cell(x, y, -1)
	remove_minerals(x,y,-1)
	treasure.get_child(0).set_cell(x, y, -1)
	tilemap.update_bitmask_area(Vector2(x,y))

func remove_minerals(x,y, id):
	for ore in minerals.get_children():
		if ore.ore.get_cell(x,y) > -1:
			ore.remove_ore(x,y)

func mine_cell(x,y):
	check_for_valuables(x,y)
	remove_cell(x,y)

func check_for_valuables(x,y):
	for ore in minerals.get_children():
		if treasure.treasure_dictionary.has(str(x,y)):
			print("Found treasure! ", treasure.treasure_dictionary.get(str(x,y)).id)
			fct_instance.get_child(0).show_value(str(treasure.treasure_name.get(str(treasure.treasure_dictionary.get(str(x,y)).id))))
			return
			
		if ore.ore.get_cell(x,y) > -1:
			print("Mined: ", ore.mineralName)
			
			# text popup on mining
			fct_instance.get_child(0).show_value(str(ore.mineralName, " +1"))  
			
			# signal found ore
			emit_signal("found_ore", ore.mineralName)
			
			
			# update score and add to inventory
			if !Global.inventory.has(ore.mineralName):
				Global.inventory[ore.mineralName] = 1
			else:
				Global.inventory[ore.mineralName] += 1
			Global.score += ore.get_score()
			print(Global.inventory[ore.mineralName])
			print(Global.get_inventory_amount())
			GlobalSignals._on_mineral_found()



# starts generating biome when pos.y > start_depth
func generate_biome(x,y):
	if y < 0: return
	if (noise.get_noise_2d(float(x), float(y)) >= -0.35) and tilemap.get_cell(x,y) != 0 and !mined_tiles.has(str(round(x),round(y))):
			
			# if a cell is to be set here, also check if its gonna have a mineral on it or details.
			tilemap.set_cell(x, y, self.tile_id)
			generate_detailing(x,y)
			generate_minerals(x,y)
			generate_treasure(x,y)
			tilemap.update_bitmask_area(Vector2(x,y))

func generate_treasure(x,y): 
	if spawn_treasure:
		treasure.generate_treasure(x,y)
	pass

func generate_detailing(x,y):
	if tile_details:
		details.generate_details(x,y)
	pass

func generate_minerals(x,y):
	if spawn_minerals:
		for child in minerals.get_children():
			child.generate_ore(x,y)
	pass
	
# generates noise
func generate_noise():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 2
	noise.period = 4
	noise.lacunarity = 1
	noise.persistence = 0.5

