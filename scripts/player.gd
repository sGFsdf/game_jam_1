extends KinematicBody2D

var velocity = Vector2(0, 0)
var direction = Vector2(0, 0)
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# TODO: Why the fuck does the character jitter SO FUCKING MUCH?  
func _physics_process(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = direction * speed 
	# move and slide takes care of framerate independant movement so we dont have to do it in this function
	# that would have been fucking nice to know before spending 3 hours trying to make framerate independant movement
	move_and_slide(velocity)
