using Godot;
using System;

[Tool]
public partial class HeartAnimations : AnimatedSprite2D
{

	public enum ANIMATIONS
	{
		DAMAGE_TAKEN,
		HEALTH_GAINED
	}

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void playHeartAnimation(ANIMATIONS animation) {
		Play(animation.ToString());
	}
}
