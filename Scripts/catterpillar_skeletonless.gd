extends Node2D

@export var segments: Array[Segment]

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
		dist.append(seg.global_position)
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
		print(distant[seg].normalized())
		#print(rot)
		#print(dist[seg])
		var perpToSurf = Vector2(0,-1)
		#print(rot)
		segments[seg].rotation =rot.angle_to(perpToSurf.normalized())
		#print(segments[seg].rotation)
	
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
