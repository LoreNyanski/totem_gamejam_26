extends Camera2D
@export var followed_node: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = followed_node.global_position - global_position
	position += velocity * delta
