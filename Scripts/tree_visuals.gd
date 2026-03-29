extends Polygon2D

# This is my original code, unfortunately slopGPT is better at
# fucking my wife than i am, so we're sticking with that one
@onready var line_2d: Line2D = $Line2D
@onready var line_2d_2: Line2D = $Line2D2


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

@onready var timer: Timer = $Timer

func _ready():
	noise.frequency = 0.2
	var points = polygon
	line_2d.points = points
	line_2d.width = base_width
	line_2d_2.points = points
	line_2d_2.width = base_width + outer_extra
	if animate: 
		timer.wait_time = texture_animation_speed
		timer.start()

func update_texture():
	var tween = create_tween()
	tween.tween_property(self, "texture_offset", texture_offset + texture_offset_change, 0.9)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	texture_offset += texture_offset_change
