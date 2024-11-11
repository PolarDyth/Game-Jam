extends HBoxContainer

@onready var heartScene = preload("res://scripts/player/hearts/heart.tscn")
@onready var health_system = $"../../health_system"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func setMaxHearts(max: int):
	for i in range(max):
		var heart = heartScene.instantiate()
		add_child(heart)

func get_hearts() -> Array:
	var hearts = get_children()
	var hearts_animation := []
	for i in range(hearts.size()):
		hearts_animation.append(hearts[i].get_child(0))
	return hearts_animation

func _on_health_system_health_changed(diff: int) -> void:
	var hearts_animation = get_hearts()
	var health = health_system.get_health()
	
	if not health_system.get_poison():
		if diff < 0:
			hearts_animation[health].play("HEALTH_TAKEN")
		else:
			hearts_animation[health - 1].play("HEALTH_GAINED")
	else:
		if diff < 0:
			hearts_animation[health].play("POISON_TAKEN")
		else:
			hearts_animation[health - 1].play("POISON_GAINED")



func _on_health_system_poison_applied(timer: Timer, poison_damage: int) -> void:
	var time = timer.wait_time
	var even_time = time / poison_damage
	var hearts_animation = get_hearts()
	
	if timer.is_connected("timeout", _on_timer_timeout):
		timer.timeout.disconnect(_on_timer_timeout)
	timer.timeout.connect(_on_timer_timeout)
	
	for i in range(health_system.get_health()):
		hearts_animation[i].play("POISON")
	
	for i in range(poison_damage):
		health_system.set_health(health_system.get_health() - 1)
		await get_tree().create_timer(even_time).timeout
	

func _on_timer_timeout():
	if health_system.get_poison() == false:
		var hearts = get_hearts()
		for i in range(health_system.get_health()):
			hearts[i].play("IDLE")
