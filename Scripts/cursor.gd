extends Node2D

@export var radius: int = 150
@export var eyes: Sprite2D

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	position = position.normalized() * min(radius, position.length())
	var dist = global_position - eyes.global_position
	eyes.rotation = dist.angle()
		

	
