extends KinematicBody2D

enum dig_direction {
	left = 1,
	right = -1,
	down = 0
}

# signals
signal dig
signal play_animation
signal dig_down
signal mine_block

# speed variables
export var speed: = Vector2(300.0, 250.0)
export var gravity: = 450.0
export var drill_speed = 100

onready var background_tiles = $"/root/GlobalTileMap"
onready var world_generator = get_parent().get_node("Current_level").get_child(0)
onready var animations = get_node("Animations")

# velocity variables
var velocity = Vector2.ZERO
var rotation_floor_degree = 0.0

# times a second frames around the player should be updated MAX 60!
const TILE_GENERATION_FPS = 4
var count = 0

var mine_down = false
var mining_direction = 0
var time = 0
var duration = 2  # length of the effect
var dir = null
var turn = false
var digging = false
var interpolate = false

var state_machine
onready var light

func _ready():
	pass
	
# visual process
func _process(delta):
	
	count += 1 
	if count % int(60 / TILE_GENERATION_FPS) == 0:
		world_generator.create_world(self.position)
		count = 0
		
	
	# global depth setter
	set_player_depth()
	
	# global Vector2 position setter
	set_player_vpos()
	
	# animates the player
	animate_player()
	
func animate_player():	
	if !digging:
		if animations.animation == "turn_to_right":
			yield(animations, "animation_finished")
		
		if velocity.x > 100:
			if dir == "left":
				animations.speed_scale = 5
				animations.play("turn_to_right", true)
				yield(animations, "animation_finished")
				dir = "right"
				animations.speed_scale = 1
			dir = "right"
			animations.play("drive_right_start")
			animations.play("drive_right")
			
		if velocity.x < -100:
			if dir == "right":
				animations.speed_scale = 5
				animations.play("turn_to_right", false)
				yield(animations, "animation_finished")
				dir = "left"
				animations.speed_scale = 1
			dir = "left"
			animations.play("drive_left_start")
			animations.play("drive_left")
			
		if velocity.x > -100 && velocity.x < -50:
			if dir == "right":
				animations.play("drive_right_stop")
		
		if velocity.x > 50 && velocity.x < 100:
			if dir == "left":
				animations.play("drive_left_stop")
				
		if velocity.x > -50 && velocity.x < 50:
			if dir == "right":
				animations.play("idle")
			if dir == "left":
				animations.play("idle_left")

# physics process
func _physics_process(delta):
	# sets current direction according to key inputs
	var direction = direction()
	
	if !digging:
		# movement and rotation instructions
		rotation_degrees = lerp(self.rotation_degrees, rotation_floor_degree*direction.x, 0.2)
		velocity = lerp(velocity, speed * direction, 0.25)
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP)
	
	if interpolate && !mine_down:
		var frame = animations.frame
		var frames = animations.frames.get_frame_count("dig_left")
		self.position  = self.position.linear_interpolate(Vector2(self.position.x + (24 * mining_direction), self.position.y), 2.0 / (frames - frame + 0.1))
	if interpolate && mine_down:
		var frame = animations.frame
		var frames = animations.frames.get_frame_count("dig_down_right")
		self.position = self.position.linear_interpolate(Vector2(self.position.x, self.position.y + 24), 2.0 / (frames - frame + 0.1))
		
	if !interpolate && !digging:
		# check if dig input
		player_dig(direction)

func player_dig(direction):
	if is_on_floor():
		if (Input.is_action_pressed("dig") and (Input.is_action_pressed("right") or Input.is_action_pressed("left"))):
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				if collision:
					emit_signal("dig", collision, self.position, direction.x)
					emit_signal("play_animation", "mine_right" if direction.x == 1 else "mine_left")
					return
					
		if (Input.is_action_pressed("dig") and (Input.is_action_pressed("down"))):
			for i in get_slide_count():
				var collision = get_slide_collision(i)
				if collision:
					emit_signal("dig", collision, self.position, dig_direction.down)
					emit_signal("play_animation", "mine_down")
					_on_Player_dig_down(collision, self.position, dig_direction.down)
					return

func direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		-1.0 if Input.get_action_strength("up") else 1.0
		)

# sets global depth according to player position. One tile = 2.5m
func set_player_depth():
	if floor(((self.position.y) + 24) / 51.2) >= 0:
		Global.depth = floor(((self.position.y) + 24) / 51.2)
	else: 
		Global.depth = 0
		
func set_player_vpos():
	Global.player_vpos = self.position

# signal catch everytime a ore is mined, text should be displayed over the character
func _on_ore_found(ore_name):
	pass


func _on_Player_dig_down(collision, pos, direct):
	var origin = self.position
	digging = true
	animations.speed_scale = 5
	if dir == "right":
		animations.play("dig_down_right")
	else:
		animations.play("dig_down_left")
	$CollisionShape2D.disabled = true
	self.gravity = 0
	interpolate = true
	mine_down = true
	
	yield(animations, "animation_finished")
	
	$CollisionShape2D.disabled = false
	self.gravity = 450
	interpolate = false
	mine_down = false
	
	emit_signal("mine_block", collision, origin, direct)
	animations.speed_scale = 1
	digging = false


func _on_Player_dig(collision, pos, dir):
	var origin = self.position
	digging = true
	animations.speed_scale = 5
	if dir == dig_direction.right:
		mining_direction = -1
		animations.play("dig_left", true)
	if dir == dig_direction.left:
		mining_direction = 1
		animations.play("dig_right", true)
		
	$CollisionShape2D.disabled = true
	self.gravity = 0
	interpolate = true
	
	yield(animations, "animation_finished")
	
	$CollisionShape2D.disabled = false
	self.gravity = 450
	interpolate = false
	
	emit_signal("mine_block", collision, origin, dir)
	animations.speed_scale = 1
	mining_direction = 0
	digging = false
