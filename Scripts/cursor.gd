extends Node2D

@export var radius: int = 75


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		position += event.relative
		position = position.normalized() * min(radius, position.length())
