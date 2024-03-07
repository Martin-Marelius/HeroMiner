extends Node2D

var mineralName = null

export var score : int = 0
export var value : int = 0

# depth the ore starts generating at in meters
export var start_depth : int = 0
export var end_depth : int = 0

# spawn rate represented as a curve
export (Curve) var spawn_curve

# noise map for the current mineral
var noise = null

# the ore tile to be placed
onready var ore = get_child(0)
onready var gradient_bg = get_child(1)

func remove_ore(x,y):
	ore.set_cell(x,y,-1)
	gradient_bg.set_cell(x,y,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_noise(Global.global_seed)
	mineralName = self.name

# one dirt cell is passed in, check if noisemap accepts then generate ore on that cell.
func generate_ore(x,y):
	if !occupied(x,y):
		var tile_meter = ((ore.map_to_world(Vector2(x,y)).y) + 24) / 51.2
		if tile_meter > self.start_depth and tile_meter < self.end_depth:
			if ((noise.get_noise_2d(x, y) <= get_current_spawnrate(tile_meter)) and noise.get_noise_2d(x, y) >= 0.0):
				ore.set_cell(x,y,0)
				gradient_bg.set_cell(x,y,0)
				ore.update_bitmask_area(Vector2(x,y))

func get_current_spawnrate(depth):
	if depth > 0:
		var real_val = 1 - ((self.end_depth - depth) / self.end_depth)
		return self.spawn_curve.interpolate(real_val) / 16
	return self.spawn_curve.interpolate(1) / 16

func occupied(x,y) -> bool:
	for N in get_parent().get_children():
		if N.get_child(0).get_cell(x,y) == 0:
			return true
	return false

func get_score() -> int:
	return self.score
	
func get_value() -> int:
	return self.value

func generate_noise(Global_seed):
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = Global_seed + self.score
	noise.octaves = 2
	noise.period = 10
	noise.lacunarity = 1
	noise.persistence = 0
