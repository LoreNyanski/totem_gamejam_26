extends RigidBody2D
class_name Segment

@export_enum("Grip1","Grip2","Grip3","Grip4","Grip5")
var grip_action: String

@onready var gripper: RayCast2D = $Gripper
var gripped: bool = false
var mouse_delta: Vector2 = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed(grip_action) and not gripped:
		var surface = find_surface()
		if surface != null: start_grip(surface)
	if Input.is_action_just_released(grip_action):
		end_grip()
	
	if not gripped: apply_central_force(mouse_delta)
	mouse_delta = Vector2.ZERO

func find_surface() -> Vector2:
	return gripper.get_collision_point()
		
func start_grip(point: Vector2) -> void:
	gripped = true
	
func end_grip() -> void:
	gripped = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_delta += event.velocity
