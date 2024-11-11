extends CollisionShape2D
@onready var health_system = get_tree().get_root().get_node("World/WorldTileSet/player/health_system")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_apply_poison_10s_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		health_system.set_temporary_poison(10, 4)
