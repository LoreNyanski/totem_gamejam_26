extends Node2D
@export var segments: Array[Char2DSeg]
#@onready var cursor: Node2D = $Middle/Cursor
@onready var cursor: Node2D = $CharacterBody2D3/Cursor
@onready var level_end_goal: Area2D = $"../LevelEndGoal"

@export var jump_strength: int = 12
@export var K = 50
@export var D : int
var saved_velocity = Vector2(0,0)
var death_y = 100
var was_gripped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.


func _process(delta: float) -> void:
	#If completed ->get_tree().change_scene_to_file("res://Scenes/mainMenu.tscn")
	
	for seg in segments:
		if seg.global_position.y > death_y:
			#play death sounds
			get_tree().change_scene_to_file("res://Scenes/main.tscn")
			
			
	var all_inside = true
	for seg in segments:

		if not level_end_goal.overlaps_body(seg):
			all_inside = false
			break

	if all_inside:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://Scenes/mainMenu.tscn")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	for n in segments.size()-1:
		
		#compute work for streching
		var m =(segments[n].global_position+segments[n+1].global_position)/2
	#	print(m)
		var deltaA = m- segments[n].global_position
	#	print(deltaA)
		@warning_ignore("integer_division")
		var x = deltaA.length() - D / 2
		var I = delta * x**3 * K*deltaA.normalized()
		#Dampen F 
		segments[n].velocity += I
		segments[n+1].velocity -= I

	for node in segments:
		node.velocity *= 0.9;
		if not some_grip():
			print(saved_velocity)
			saved_velocity *= 1 - (0.15 * delta)
		#compute work for i forgor
		
		
	#for n in segments.size()-2:
	#
		#var m =(segments[n].global_position+segments[n+2].global_position)/2
		#var deltaB = segments[n+1].global_position-m
		#segments[n].velocity+=delta*C*deltaB
		#segments[n+2].velocity+=delta*C*deltaB

	#	

		#
	#var dist : Array[Vector2]
	#var distant : Array[Vector2]
	#for seg in segments:
		##print(1)
		#dist.append(seg.grip_ray.global_position)
	#for d in dist.size() :
		#if d==0 :
			#distant.append((dist[d+1]-dist[d])/2)		
		#elif d==dist.size()-1:
			#distant.append((dist[d]-dist[d-1])/2)
		#else:
			#var kk = (dist[d]-dist[d-1])/2 + (dist[d+1]-dist[d])/2
			#distant.append(kk/2)
	#
	#for seg in segments.size():
		#var rot = Vector2(-distant[seg][1],-distant[seg][0]).normalized()
		##print(distant[seg].normalized())
		##print(rot)
		##print(dist[seg])
		#var perpToSurf = Vector2(0,-1)
		##print(rot)
		##segments[seg].rotation =rot.angle_to(perpToSurf.normalized())
		##if not segments[seg].gripped:
			##segments[seg].rotate_pivot(rot.angle_to(perpToSurf.normalized()))
		##print(segments[seg].rotation)
	
	var grip_dist = dist_to_grip()
	@warning_ignore("shadowed_global_identifier")
	if some_grip():
		for i in segments.size():
			var force = (cursor.global_position - segments[i].global_position).normalized() * grip_dist[i] * 500
			segments[i].velocity+=force*delta

func set_saved_velocity():
	saved_velocity = Vector2.ZERO
	for segment in segments:
		var dist = segment.travelled_dist() * jump_strength
		if dist.length() > saved_velocity.length(): saved_velocity = dist 

func some_grip() -> bool:
	for segment in segments:
		if segment.gripped: return true
	return false
	
func dist_to_grip():
	var grip_dist_array = []
	var counter = 99
	for segment in segments:
		if segment.gripped: 
			grip_dist_array.append(0)
			counter = 0
		else:
			if not counter == 99: counter += 1
			grip_dist_array.append(counter)
	counter = -1
	for i in range(segments.size()-1, -1, -1):
		if segments[i].gripped: 
			counter = 0
		else:
			if counter == -1: continue
			counter += 1
			grip_dist_array[i] = min(grip_dist_array[i], counter)
	return grip_dist_array	
