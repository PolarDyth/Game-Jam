using Godot;
using System;
using System.Linq;

public partial class HeartContainer : HBoxContainer
{

	// Preload Scenes
	private readonly PackedScene HeartScene = GD.Load<PackedScene>("res://scripts/player/hearts/heart.tscn");

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{

	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public void setMaxHeart(int max) 
	{
		for (int i = 0; i < max; i++) 
		{
			AddChild(HeartScene.Instantiate());
		}
	}

	public void updateHearts(int current, HeartAnimations.ANIMATIONS animation) 
	{
		// var hearts = GetChildren().Where(child => child is HeartAnimations).Select(child => child).Cast<HeartAnimations>();
		var hearts = (HeartAnimations) GetChildren();


		for (int i = 0; i < hearts.Count(); i++) 
		{
			hearts[i].playHeartAnimation(animation);
		}
	}
}
