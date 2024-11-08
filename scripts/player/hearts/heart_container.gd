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


func _on_health_system_health_changed(diff: int) -> void:
	print(diff)
	var hearts = get_children()
	var heartsAnimation := []
	var health = health_system.get_health()
	for i in range(hearts.size()):
		heartsAnimation.append(hearts[i].get_child(0))
		
	if diff < 0:
		heartsAnimation[health].play("HEALTH_TAKEN")
	else:
		heartsAnimation[health - 1].play("HEALTH_GAINED")
