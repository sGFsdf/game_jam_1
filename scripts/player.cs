// disables warnings about name violations 
#pragma warning disable IDE1006

using Godot;
using System;

public class player : KinematicBody2D {
	const int speed = 100; 
	
	// Called when the node enters the scene tree for the first time.
	public override void _Ready(){
		GD.Print("Player Script has been activated!!"); 
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _PhysicsProcess(float delta)
	{
		Vector2 direction = Input.GetVector("move_left", "move_right", "move_up", "move_down"); 
		direction =  direction.Normalized(); 

		Vector2 velocity = direction * speed; 

		MoveAndSlide(velocity);
	}
}
