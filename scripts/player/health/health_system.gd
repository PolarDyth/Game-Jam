extends Node

class_name Health_System

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#region SIGNAL
signal max_health_changed(diff: int)
signal health_changed(diff: int)
signal health_depleted
signal poison_applied(timer: Time, poison_amount: float)
#endregion

#region VARIABLES
@export var max_health: int = 5 : set = set_max_health, get = get_max_health
@export var immortality: bool = false : set = set_immortality, get = get_immortality
@export var poison: bool = false : set = set_poison, get = get_poison

var immortality_timer: Timer = null
var poison_timer: Timer = null

@onready var health: int = max_health : set = set_health, get = get_health
#endregion

#region GETTERS AND SETTERS
func set_max_health(value: int):
	var clamped_value = 1 if value <= 0 else value
	
	if not clamped_value == max_health:
		var difference = clamped_value - max_health
		max_health = value
		max_health_changed.emit(difference)

func get_max_health() -> int:
	return max_health

func set_immortality(value: bool):
	immortality = value

func get_immortality():
	return immortality

func set_poison(value: bool):
	poison = value

func get_poison():
	return poison

func set_health(value: int):
	if value < health and immortality:
		return
	
	var clamped_value = clampi(value, 0, max_health)
	
	if clamped_value != health:
		var difference = clamped_value - health
		health = value
		health_changed.emit(difference)
		
		if health == 0:
			health_depleted.emit()

func get_health():
	return health
#endregion

func set_temporary_poison(time: float, poison_amount: float):
	
	if poison:
		return
	
	if poison_timer == null:
		poison_timer = Timer.new()
		poison_timer.one_shot = true
		add_child(poison_timer)
	
	if poison_timer.timeout.is_connected(set_poison):
		poison_timer.timeout.disconnect(set_poison)
	
	print(poison_timer)
	poison_timer.set_wait_time(time)
	poison_timer.timeout.connect(set_poison.bind(false))
	poison = true
	poison_timer.start()
	poison_applied.emit(poison_timer, poison_amount)

func set_temporary_immortality(time: float):
	if immortality_timer == null:
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)
	
	if immortality_timer.timeout.is_connected(set_immortality):
		immortality_timer.timeout.disconnect(set_immortality)
	
	immortality_timer.set_wait_time(time)
	immortality_timer.timeout.connect(set_immortality.bind(false))
	immortality = true
	immortality_timer.start()
