extends Node2D

const SCREEN_WIDTH = 576
const SCREEN_HEIGHT = 1024

# tiles in the map
const MAP_WIDTH = 600
const MAP_DEPTH = 500

var score = 0
var depth = 0

var global_seed = 1

var furnace_on = false

# inventory of the player, each key is the mineral name
var inventory = {} 

# sales cost of all minerals
var marketprice = {}

# crystal balance, initial value is starting balance
var crystal = 0

# cash balance, initial value is starting balance
var cash = 60

# current values updated in realtime
var current_health
var current_fuel

# player position in Vector2
var player_vpos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_fuel = Stats.fuel_tank
	Global.current_health = Stats.hull
	pass # Replace with function body.

# returns how many ore the player has in their inventory
func get_inventory_amount() -> int:
	var amount = 0 
	for i in inventory.values():
		amount += i
	return amount

# returns meter depth from y world value
func world_to_meter(y):
	return floor(((y) + 24.0) / 51.2)
	
func meter_to_world(y):
	return floor(51.2 * y) - 24.0
