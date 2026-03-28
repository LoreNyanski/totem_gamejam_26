extends Node2D

@export var segments: Array[Segment]
@onready var cursor: Node2D = $Middle/Cursor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#Get vector between center of vectors
	#If edge segment -> normalize
	#Else average vectors and then normalize
	#rotate based on the normal
	var dist : Array[Vector2]
	var distant : Array[Vector2]
	for seg in segments:
		#print(1)
		dist.append(seg.grip_ray.global_position)
	for d in dist.size() :
		if d==0 :
			distant.append((dist[d+1]-dist[d])/2)		
		elif d==dist.size()-1:
			distant.append((dist[d]-dist[d-1])/2)
		else:
			var kk = (dist[d]-dist[d-1])/2 + (dist[d+1]-dist[d])/2
			distant.append(kk/2)
	
	for seg in segments.size():
		var rot = Vector2(-distant[seg][1],-distant[seg][0]).normalized()
		#print(distant[seg].normalized())
		#print(rot)
		#print(dist[seg])
		var perpToSurf = Vector2(0,-1)
		#print(rot)
		#segments[seg].rotation =rot.angle_to(perpToSurf.normalized())
		if not segments[seg].gripped:
			segments[seg].rotate_pivot(rot.angle_to(perpToSurf.normalized()))
		#print(segments[seg].rotation)
	
	var grip_dist = dist_to_grip()
	var str = grip_str()
	for i in segments.size():
		var force = (cursor.global_position - segments[i].global_position).normalized() * grip_dist[i] * str * 500
		segments[i].apply_central_force(force)

func grip_str() -> int:
	var num_grips = 0
	for segment in segments:
		if segment.gripped: num_grips += 1
	return num_grips
	
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
