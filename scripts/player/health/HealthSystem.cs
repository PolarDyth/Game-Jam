using Godot;
using System;

[GlobalClass]
public partial class HealthSystem : Node
{

	// Fields
	private int _health;
	private bool _isInvulnerable;
	private float _invulnerableTime = 1.0f;
	private int _maxHealth = 20;
	private int _healthRegen;
	private float _healthRegenTickTime = 1.0f;


	public enum TYPES
	{
		HEALTH,
		DAMAGE,
		HEALTH_REGEN
	}

	// Signals
	[Signal]
	public delegate void HealthChangedEventHandler(int amount, int type);
	public delegate void InvulnerableEventHandler(bool isInvulnerable);
	public delegate void DiedEventHandler();

	#region parameters

	[ExportGroup("Health Parameters")]
	[Export]
	public int MaxHealth { get { return _maxHealth; } set { _maxHealth = Mathf.Max(0, value); } }
	[Export]
	public int CurrentHealth { get { return _health; } set { _health = Mathf.Clamp(value, 0, _maxHealth); } }

	[ExportGroup("Additional Behaviours")]
	[Export]
	public int HealthRegen { get { return _healthRegen; } set { _healthRegen = Mathf.Max(0, value); } }
	[Export]
	public float HealthRegenTickTime { get { return _healthRegenTickTime; } set { _healthRegenTickTime = Mathf.Max(0, value); } }
	[Export]
	public bool IsInvulnerable { get { return _isInvulnerable; } set { _isInvulnerable = value; } }
	[Export]
	public float InvulnerableTime { get { return _invulnerableTime; } set { _invulnerableTime = Mathf.Max(0, value); } }

	#endregion

	public Timer InvulnerabilityTimer;
	public Timer HealthRegenTimer;

	public override void _Ready()
	{
		_health = _maxHealth;
	}

	public void Health(int amount, TYPES type = TYPES.HEALTH) 
	{
		amount = Mathf.Abs(amount);
		CurrentHealth = Mathf.Min(_maxHealth, CurrentHealth + amount);I go

		EmitSignal(SignalName.HealthChanged, amount, (int)type);
	}

	public void Damage(int amount, TYPES type = TYPES.DAMAGE) 
	{
		if (IsInvulnerable)
		{
			amount = 0;
		}

		Mathf.Abs(amount);
		CurrentHealth = Mathf.Max(0, CurrentHealth - amount);
		EmitSignal(SignalName.HealthChanged, amount, (int)type);
	}
}