extends Node2D

onready var detailset = $detailset
onready var tilemap = $"/root/GlobalTileMap"

var detail_dictionary = {}

var noise = null

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_noise()
	pass # Replace with function body.

# generate details for x and y procedurally while moving around
func generate_details(x,y):
	if detailset == null: return
	if noise.get_noise_2d(float(x), float(y)) >= 0.2 and noise.get_noise_2d(float(x), float(y)) <= 0.22:
		
		var key = str(x,y)
		if detail_dictionary.has(key):
			detailset.set_cell(x,y,0,false,false,false,detail_dictionary.get(key).id)
			return
		
		var rtile = get_random_autotile()
		detailset.set_cell(x,y,0,false,false,false,rtile)
		
		detail_dictionary[key] = {"id" : rtile}

func get_random_autotile() -> Vector2:
	return Vector2(int(randi()%5),int(randi()%4))

func _process(delta):
	pass

func remove_detail():
	for detail in detail_dictionary:
		if tilemap.get_cell(detail.x, detail.y) == -1:
			detailset.set_cell(detail.x,detail.y, -1)
	pass

func generate_noise():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	
	noise.octaves = 2
	noise.period = 4
	noise.lacunarity = 1
	noise.persistence = 0.5
