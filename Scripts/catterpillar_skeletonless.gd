extends Node2D

@export var segments: Array[Segment]

@onready var cursor: Node2D = $Middle/Cursor

func _physics_process(delta: float) -> void:
	for segment in segments:
		var force = (cursor.global_position - segment.global_position) * grip_str() * 20
		segment.apply_central_force(force)

func grip_str() -> int:
	var num_grips = 0
	for segment in segments:
		if segment.gripped: num_grips += 1
	return num_grips
