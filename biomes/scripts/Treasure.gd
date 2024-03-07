extends Node2D

onready var treasureset = $treasureset
onready var tilemap = $"/root/GlobalTileMap"

var treasure_dictionary = {}

var treasure_name = {
	"(0, 0)":"Bracelet",
	"(1, 0)":"Chalice",
	"(2, 0)":"Amulet",
	"(3, 0)":"Necklace",
	"(0, 1)":"Rare wand",
	"(1, 1)":"Golden Beetle",
	"(2, 1)":"Golden Bracelet",
	"(3, 1)":"Crown",
	"(0, 2)":"Diamond Ring",
	"(1, 2)":"Tiara",
	"(2, 2)":"Golden Lantern",
	"(3, 2)":"Rare Crown"
}

var noise = null

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_noise()
	pass # Replace with function body.

# generate details for x and y
func generate_treasure(x,y):       
	if treasureset == null: return
	if !occupied(x,y):
		if noise.get_noise_2d(float(x), float(y)) >= 0.2 and noise.get_noise_2d(float(x), float(y)) <= 0.201:
			var key = str(x,y)
			if treasure_dictionary.has(key):
				treasureset.set_cell(x,y,0,false,false,false,treasure_dictionary.get(key).id)
				return
			
			var rtile = get_random_autotile()
			treasureset.set_cell(x,y,0,false,false,false,rtile)
			
			treasure_dictionary[key] = {"id" : rtile}

func get_random_autotile() -> Vector2:
	return Vector2(int(randi()%4),int(randi()%3))

func occupied(x,y) -> bool:
	for N in get_parent().get_node("Minerals").get_children():
		if N.get_child(0).get_cell(x,y) == 0:
			return true
	return false


func _process(delta):
	pass

func remove_treasure():
	for treasure in treasure_dictionary:
		if tilemap.get_cell(treasure.x, treasure.y) == -1:
			treasureset.set_cell(treasure.x,treasure.y, -1)
	pass

func generate_noise():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	
	noise.octaves = 2
	noise.period = 4
	noise.lacunarity = 1
	noise.persistence = 0.5
