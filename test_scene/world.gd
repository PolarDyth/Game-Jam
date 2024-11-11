extends Node2D

@onready var heartsContainer = $WorldTileSet/player/playerCam/heart_container
@onready var health_system = get_tree().get_root().get_node("World/WorldTileSet/player/health_system")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	heartsContainer.setMaxHearts(health_system.get_health())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
