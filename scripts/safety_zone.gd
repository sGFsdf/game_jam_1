extends Area2D

func _on_safey_zone_body_entered(body):
	print("AaaASdasdjkhbhjadhbj")
	if body.name == "scientist": 
		body.entered_safe_zone = true
