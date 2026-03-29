extends Node2D

@export var radius: int = 150
@export var eyes: Sprite2D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		position += event.relative
		position = position.normalized() * min(radius, position.length())
		var dist = global_position - eyes.global_position
		eyes.rotation = dist.angle()
	
