extends CollisionShape2D

@onready var health_system = get_tree().get_root().get_node("World/WorldTileSet/player/health_system")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#health_system.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_body_entered(body: Node2D) -> void:#
	if body.is_in_group("player"):
		health_system.set_health(health_system.get_health() - 1)
