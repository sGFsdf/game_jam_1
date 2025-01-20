extends KinematicBody2D

export var speed = 100

var player: KinematicBody2D
var target_vector: Vector2

func _ready():
	player = get_player() 

func _physics_process(delta):
	target_vector = (player.position - position).normalized()
	move_and_slide(target_vector * speed)

func get_player():
	var nodes = get_tree().get_nodes_in_group("player")
	if len(nodes) > 0:
		return nodes[0]
	else: 
		push_error("Player not found!")
