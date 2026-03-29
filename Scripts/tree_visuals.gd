extends Polygon2D

@onready var line_2d: Line2D = $Line2D
@onready var line_2d_2: Line2D = $Line2D2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var points = polygon
	points.append(polygon[0])
	line_2d.points = points
	line_2d_2.points = points
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
