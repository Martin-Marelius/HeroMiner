extends Node2D

# add all biomes as child
onready var biomes = get_node("Biomes").get_children()
onready var tiles = $"/root/GlobalTileMap"

signal position_player_on_mine

# Camera boundaries for how many tiles gets spawned around the player min x: 7, y: 11
const BOUNDARY_X = 8
const BOUNDARY_Y = 11


# Called when the node enters the scene tree for the first time.
func _ready():
	# connect dig signal to player character
	get_parent().get_parent().get_node("Player").connect("mine_block", self, "_on_Player_dig")

func dig_tile(x,y):
	var tile = tiles.get_cell(x,y)
	var has_tile = tile > -1
	if has_tile:
		get_biome(y).mine_cell(x,y)

# creates the world around the player.
func create_world(player_position):
	var pos = tiles.world_to_map(player_position)
	var boundaries = generate_boundaries(pos)
	draw_tiles(boundaries)
	un_draw_tiles(pos) # removes all tiles +3 around camera boundaries
	
	
# set in boundaries to be removed.
func remove_tiles(boundaries):
	for i in boundaries:
		var tile = tiles.get_cell(i.x,i.y)
		var has_tile = tile > -1
		if has_tile:
			var current_biome = get_biome(i.y)
			current_biome.remove_cell(i.x,i.y)

# generates a tile on the background tile. inside boundaries
func draw_tiles(boundaries):
	for i in boundaries:
		var tile = tiles.get_cell(i.x,i.y)
		var has_tile = tile > -1
		if !has_tile:
			var current_biome = get_biome(i.y)
			current_biome.generate_biome(i.x,i.y)

# returns the biome in the depth y
func get_biome(y):
	var b = biomes[0]
	
	var depth = (tiles.map_to_world(Vector2(0.0,y)).y + 24) / 51.2
	
	for biome in biomes:
		
		if depth >= biome.start_depth:
			b = biome
	
	return b

# generate boundaries around player that are to be tiles
func generate_boundaries(pos):
	var boundaries = [pos]
	
	for x in BOUNDARY_X:
		for y in BOUNDARY_Y:
			boundaries.append({
				"x": pos.x + x,
				"y": pos.y + y
			})
			boundaries.append({
				"x": pos.x - x,
				"y": pos.y - y
			})
			boundaries.append({
				"x": pos.x + x,
				"y": pos.y - y
			})
			boundaries.append({
				"x": pos.x - x,
				"y": pos.y + y
			})
	return boundaries

# can be optimized, removes tiles 3 around player boundaries.
func un_draw_tiles(pos):
	var boundaries = [pos]
	for x in BOUNDARY_X + 3:
		for y in BOUNDARY_Y + 3:
			if x < BOUNDARY_X and y < BOUNDARY_Y:
				# do nothing
				pass
			else:
				boundaries.append({
					"x": pos.x + x,
					"y": pos.y + y
				})
				boundaries.append({
					"x": pos.x - x,
					"y": pos.y - y
				})
				boundaries.append({
					"x": pos.x + x,
					"y": pos.y - y
				})
				boundaries.append({
					"x": pos.x - x,
					"y": pos.y + y
				})
	remove_tiles(boundaries)


# dig a block in the given direction
func _on_Player_dig(collision, player_position, direction):
	# check if mining downwards
	if direction == 0:
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(player_position)
			tile_pos -= collision.normal
			var tile = collision.collider.get_cellv(tile_pos)
			
			if tile > -1:
				var key = str(round(tile_pos.x), round(tile_pos.y))
				tiles.mined_tiles[key] = 1
				get_biome(tile_pos.y).mine_cell(tile_pos.x,tile_pos.y)
				Global.score += get_biome(tile_pos.y).score
				emit_signal("position_player_on_mine", tile_pos.y, 0)
				return
	
	# Check if mining to the right
	if direction == 1:
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(player_position)
			tile_pos.x += direction 
			var tile = collision.collider.get_cellv(tile_pos)
			if tile > -1:
				var key = str(round(tile_pos.x), round(tile_pos.y))
				tiles.mined_tiles[key] = 1
				get_biome(tile_pos.y).mine_cell(tile_pos.x,tile_pos.y)
				Global.score += get_biome(tile_pos.y).score
				return
				
	# Check if mining to the left
	if direction == -1:
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(player_position)
			tile_pos.x += direction  
			var tile = collision.collider.get_cellv(tile_pos)
			if tile > -1:
				var key = str(round(tile_pos.x), round(tile_pos.y))
				tiles.mined_tiles[key] = 1
				get_biome(tile_pos.y).mine_cell(tile_pos.x,tile_pos.y)
				Global.score += get_biome(tile_pos.y).score
				return
	return
