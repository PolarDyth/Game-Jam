extends Camera2D

@onready var player = $"../../player"
@onready var area = get_tree().get_root().get_node("World/Area2D")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(area)
	area.area_entered.connect(_on_player_enter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_player_enter(body: Node2D):
	print("worked")
	print(round(get_target_position().x))
	print(get_target_position().y)
	if round(get_target_position().x) < -25 && round(get_target_position().x) > -30:
		set_limit(SIDE_LEFT, 100000000)
		set_limit(SIDE_RIGHT, -33)
		player.position = Vector2(-70, get_target_position().y)
	else:
		set_limit(SIDE_LEFT, -33)
		set_limit(SIDE_RIGHT, 100000000)
		player.position = Vector2(-9, get_target_position().y)
