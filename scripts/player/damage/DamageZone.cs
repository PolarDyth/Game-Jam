using Godot;
using System;

public partial class DamageZone : Area2D
{

	HealthSystem healthSystem;
	private void _on_body_entered(Node body) {
		healthSystem = GetNode<HealthSystem>("/root/Player/HealthSystem");
		GD.Print("DamageZone body_entered");

		healthSystem.Health.set(healthSystem.Health.get() - 1); 


	}
}
