extends Node2D

# globals stats for the player, dictates current vehicle upgrades.

# digging speed multiplier of the character, default 1.0 (starting value)
export var dig_speed : float = 1.0 

# how big the fuel tank is in liters
export var fuel_tank : float = 12.0

# how many ores can be held at once in the cargo
export var max_cargo : int = 10

# health / armor of the vehicle
export var hull : float = 100.0

# engine efficiency
export var engine_efficiency : float = 1.0

# driving speed multiplier
export var belt_speed : float = 1.0

# flight speed multiplier
export var flight_speed : float = 1.0

# light multiplier to see better in the deep.
export var light : float = 1.0

