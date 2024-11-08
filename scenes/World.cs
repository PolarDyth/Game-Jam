using Godot;
using System;

public partial class World : TileMapLayer
{

	HeartContainer heartContainer;

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		heartContainer = GetNode<HeartContainer>("/root/WorldScene/WorldTileSet/Player/playerCam/heartContainer");
		heartContainer.setMaxHeart(5);
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}
