using Godot;
using System;

[GlobalClass]
public partial class HealthSystem : Node
{


	// Signals
	[Signal]
	public delegate void maxHealthChangedEventHandler(int maxHealth);
	[Signal]
	public delegate void HealthChangedEventHandler(int health);
	[Signal]
	public delegate void HealthDepletedEventHandler();

	// Backing fields
	private int _health = 0; // Default value for health
	private int _maxHealth = 20; // Default value for maxHealth
	private bool _invincible = false; // Default value for invincible

	// Properties

	[Export]
	public int Health
	{
		get
		{
			return _health;
		}
		set
		{
			_health = value;
			EmitSignal("HealthChangedEventHandler", _health);
			GD.Print("Health changed to: " + _health);

			if (_health <= 0)
			{
				EmitSignal("HealthDepletedEventHandler");
			}
		}
	}

	[Export]
	private int MaxHealth
	{
		get 
		{
			return _maxHealth;
		}
		set
		{ 
			if (value < 0)
			{
				_maxHealth = 0;
			}
			else
			{
				_maxHealth = value;
			}
		}
	}

	[Export]
	private bool Invincible
	{ 
		get { return _invincible; }
		set { _invincible = value; }
	}

	private Timer immuneTimer = new Timer();

	// Methods

	public void TakeDamage(int damage)
	{
		if (!_invincible)
		{
			_health -= damage;
		}
	}
}