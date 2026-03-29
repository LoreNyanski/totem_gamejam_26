extends Polygon2D

# This is my original code, unfortunately slopGPT is better at
# fucking my wife than i am, so we're sticking with that one
#@onready var line_2d: Line2D = $Line2D
#@onready var line_2d_2: Line2D = $Line2D2
#
#func _ready() -> void:
	#var points = polygon
	#line_2d.points = points
	#line_2d_2.points = points

@export var spacing: float = 10.0
@export var wobble_strength: float = 2
@export var base_width: float = 4.0
@export var outer_extra: float = 2.0

@export var animate: bool = true
@export var animation_speed: float = 2.0
@export var texture_animation_speed: float = 1.0
@export var texture_offset_change: Vector2 = Vector2(10, 20)

var noise := FastNoiseLite.new()
var time := 0.0

@onready var outer_mesh := $MeshInstance2D
@onready var inner_mesh := $MeshInstance2D2
@onready var timer: Timer = $Timer

func _ready():
	noise.frequency = 0.2
	update_outline()
	if animate: 
		timer.wait_time = texture_animation_speed
		timer.start()
		
func _process(delta):
	if animate:
		time += delta * animation_speed
		update_outline()

func update_texture():
	var tween = create_tween()
	tween.tween_property(self, "texture_offset", texture_offset + texture_offset_change, 0.9)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	texture_offset += texture_offset_change

func update_outline():
	
	var base_points = polygon
	var wobbly = build_wobbly_edge(base_points)

	# Outer (white)
	outer_mesh.mesh = build_stroke_mesh(wobbly, base_width + outer_extra)
	outer_mesh.modulate = Color.WHITE

	# Inner (black)
	inner_mesh.mesh = build_stroke_mesh(wobbly, base_width)
	inner_mesh.modulate = Color.BLACK


# 🔹 Build continuous wobbly edge
func build_wobbly_edge(points: PackedVector2Array) -> PackedVector2Array:
	var result = PackedVector2Array()

	for i in range(points.size()):
		var a = points[i]
		var b = points[(i + 1) % points.size()]

		var edge = b - a
		var length = edge.length()
		var dir = edge.normalized()
		var normal = dir.orthogonal()

		var steps = max(1, int(length / spacing))

		for j in range(steps):
			var t = float(j) / steps
			var pos = a.lerp(b, t)

			# multi-layer noise = nicer wobble
			var n1 = noise.get_noise_3d(pos.x * 0.05, pos.y * 0.05, time)
			var n2 = noise.get_noise_3d(pos.x * 0.2, pos.y * 0.2, time) * 0.3
			var n = n1 + n2

			pos += normal * n * wobble_strength
			result.append(pos)

	return result


# 🔹 Build mesh strip (stroke)
func build_stroke_mesh(path: PackedVector2Array, width: float) -> ArrayMesh:
	var mesh = ArrayMesh.new()

	var vertices = PackedVector2Array()
	var indices = PackedInt32Array()

	for i in range(path.size()):
		var p = path[i]
		var next = path[(i + 1) % path.size()]
		var dir = (next - p).normalized()
		var normal = dir.orthogonal()

		# slight width variation (hand-drawn feel)
		var w = width * (0.85 + randf() * 0.3)

		vertices.append(p + normal * w * 0.5)
		vertices.append(p - normal * w * 0.5)

	for i in range(path.size() - 1):
		var idx = i * 2

		indices.append(idx)
		indices.append(idx + 2)
		indices.append(idx + 1)

		indices.append(idx + 1)
		indices.append(idx + 2)
		indices.append(idx + 3)

	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indices

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	return mesh
