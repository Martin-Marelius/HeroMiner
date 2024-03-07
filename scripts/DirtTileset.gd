extends TileMap

var noise
var mined_tiles = {} # dictionary of every mined tiles.

onready var tilemap = $"/root/GlobalTileMap"

signal ore_found

# Called when the node enters the scene tree for the first time.
func _ready():
	# generate noise
	generate_noise()
	
	# generate spawn
	generate_spawn()

func generate_noise():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	
	noise.octaves = 2
	noise.period = 4
	noise.lacunarity = 1
	noise.persistence = 0.5

# generates a cell at x,y with the id
func generate(x, y, id):
	if y >= 5:
		if (noise.get_noise_2d(float(x), float(y)) >= -0.35) and self.get_cell(x,y) != 0 and !mined_tiles.has(str(round(x),round(y))):
				
				# if a cell is to be set here, also check if its gonna have a mineral on it or details.
				self.set_cell(x, y, id)
				#generate_detailing(x,y)
				generate_minerals(x,y)
				self.update_bitmask_area(Vector2(x,y))

func generate_minerals(x,y):
	
	# which child to look for minerals in
	var minerals = $Minerals
	
	# generate minerals for every children in minerals.
	for child in minerals.get_children():
		child.generate_ore(x,y)

func generate_spawn():
	var width = int(Global.MAP_WIDTH / 2)
	
	for x in Global.MAP_WIDTH:
		self.set_cell((x - width), 0, 1)
		for y in 5:
			self.set_cell((x - width), y+1, 0)
			
	self.update_bitmask_region()

# dig a block in the given direction
func _on_Player_dig(collision, player_position, direction):
	# check if mining downwards
	if direction == 0:
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(player_position)
			tile_pos -= collision.normal
			var tile = collision.collider.get_cellv(tile_pos)
			if tile == 0 or 1:
				var key = str(round(tile_pos.x), round(tile_pos.y))
				mined_tiles[key] = 1
				contains_ore(tile_pos)
				self.set_cell(tile_pos.x, tile_pos.y, -1)
				update_bitmask_area(tile_pos)
				Global.score += 10
				return
	
	# Check if mining to the right
	if direction == 1:
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(player_position)
			tile_pos.x += direction 
			var tile = collision.collider.get_cellv(tile_pos)
			if tile == 0 or 1:
				var key = str(round(tile_pos.x), round(tile_pos.y))
				mined_tiles[key] = 1
				contains_ore(tile_pos)
				self.set_cell(tile_pos.x, tile_pos.y, -1)
				update_bitmask_area(tile_pos)
				Global.score += 10
				return
				
	# Check if mining to the left
	if direction == -1:
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(player_position)
			tile_pos.x += direction  
			var tile = collision.collider.get_cellv(tile_pos)
			if tile == 0 or 1:
				var key = str(round(tile_pos.x), round(tile_pos.y))
				mined_tiles[key] = 1
				contains_ore(tile_pos)
				self.set_cell(tile_pos.x, tile_pos.y, -1)
				update_bitmask_area(tile_pos)
				Global.score += 10
				return
	return

func remove_ore(position):
	for N in get_child(0).get_children():
		if N.get_child(0).get_cellv(position) == 0:
			N.get_child(0).set_cellv(position, -1)
			N.get_child(1).set_cellv(position, -1)

func contains_ore(position):
	# check first if there is ore and removes the ore
	for N in get_child(0).get_children():
		if N.get_child(0).get_cellv(position) == 0:
			N.get_child(0).set_cellv(position, -1)
			N.get_child(1).set_cellv(position, -1)
			Global.score += N.get_score()
			emit_signal("ore_found", N.get_name())
	
	# checks if there is any detailing that has to be removed
	for N in get_child(1).get_children():
		if N.get_cellv(position) >= 0:
			N.set_cellv(position, -1) 
	return 
	
