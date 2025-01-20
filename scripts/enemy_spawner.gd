extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func find_enemies():
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies: 
		print(enemy)
