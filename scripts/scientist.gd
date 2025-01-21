# Generic non-damaging enemies
extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite

# speed that the enemy moves at. Not sure what units these are in 
export var speed = 100

# reference to player
var player: KinematicBody2D

# target vector is going to be the vector pointing in the direction of the player character 
var target_vector: Vector2

# using a heart system means that each portion of the heart will corospond to a single in:
# ie. if you have 2 hearts, then you have 6 health 
export var max_health = 100
export(float) var current_health: float

# for animations
# this is basically a state so I am going to continue to use it as a state
# if that gets confusing, it's because it is, but whatever
var face_direction

# kind of a state variable
var entered_safe_zone: bool = false 

# keep track of damage taken for debugging? 
export var damage_taken: int

# time for the death of the enemy
var time = 5.0

# time 
export var elapsed_seconds = 0

# I want there to be a random chance the scientist isnt afraid and may randomly attack you 
var afraid: bool = true 

# on load function
func _ready():
	_animated_sprite.stop()
	_animated_sprite.play("scientist_idle") 
	player = get_player() 
	current_health = max_health

# called every frame
# god I am fucking sorry for writing such awful code
# god save us all
func _physics_process(delta):
	if current_health <= 0:
		wait_seconds_to_die(delta, time)
		print("I am dead :(")
		return 
	
	var closest_safe_zone = get_distance_to_safe_zones()
	
	print(closest_safe_zone)
	
	# if we are moving
	# FYI, I have no fucking clue what this does, I just copied it from google and it works
	if not entered_safe_zone:
		if target_vector.length() > 0: 
			if abs(target_vector.x) > abs(target_vector.y):
				face_direction = "scientist_walk_left" if target_vector.x < 0 else "scientist_walk_right"
			else:
				face_direction = "scientist_walk_away" if target_vector.y < 0 else "scientist_walk_toward"
		# otherwise we are not moving and set it to the idle animation
		else:
			face_direction == "scientist_idle"
		
		# because we don't have a left walk animation I have to flip the sprite in engine
		# works completely fine
		if face_direction == "scientist_walk_left":
			_animated_sprite.flip_h = true
			_animated_sprite.play("scientist_walk_right")
		else:	
			_animated_sprite.flip_h = false
			_animated_sprite.play(face_direction)

		move_and_slide(target_vector * speed)
	else: 
		safe_zone_function() 

# gets a player reference
# TODO: if it becomes multiplayer then we need to get multiple player references 
func get_player():
	var nodes = get_tree().get_nodes_in_group("player")
	if len(nodes) > 0:
		return nodes[0]
	else: 
		push_error("Player not found!")
		
# not even I know
func wait_seconds_to_die(delta, body_decay_time: float):
	elapsed_seconds += delta
	_animated_sprite.play("scientist_death")
	if elapsed_seconds >= body_decay_time:
		self.queue_free()

func safe_zone_function():
	_animated_sprite.play("scientist_turn_around")
	# this is todo, need to add mechanics for this to work more

# the "Safe zones" are not actually safe
func get_distance_to_safe_zones() -> Vector2:
	var safe_zones = get_tree().get_nodes_in_group("safe_zones")
	var distance = Vector2.ZERO
	for zone in safe_zones:
		print("found a zone!")
		var old_distance = distance
		distance = position.distance_to(zone)
		if old_distance > distance:
			distance = old_distance
	return distance
		

# boiler plate function for placing in functions that need to be created still so godot doesnt bitch
func TODO():
	push_error("TODO")
