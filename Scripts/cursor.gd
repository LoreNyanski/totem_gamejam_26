extends Node2D

@export var radius: int = 150


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		position += event.relative
		position = position.normalized() * min(radius, position.length())
