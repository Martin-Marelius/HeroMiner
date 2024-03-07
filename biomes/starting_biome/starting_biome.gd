extends "res://biomes/scripts/Biome.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	noise.octaves = 10
	pass # Replace with function body.

func generate_biome(x,y):
	if y < 0: return
	if !mined_tiles.has(str(round(x),round(y))):
		tilemap.set_cell(x, y, self.tile_id)
		tilemap.update_bitmask_area(Vector2(x,y))

func remove_cell(x, y):
	var building_bounds
	if y >= 0:
		tilemap.set_cell(x, y, -1)
		details.get_child(0).set_cell(x, y, -1)
		remove_minerals(x,y,-1)
		
		tilemap.update_bitmask_area(Vector2(x,y))
