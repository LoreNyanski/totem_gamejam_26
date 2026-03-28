extends RigidBody2D
class_name Segment

@export_enum("Grip1","Grip2","Grip3","Grip4","Grip5")
var grip_action: String

@onready var grip_ray: RayCast2D = $Grip_ray
var gripper: PinJoint2D
var gripped: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed(grip_action) and not gripped:
		var surface = grip_ray.get_collider()
		if surface != null: start_grip(surface)
	if Input.is_action_just_released(grip_action):
		end_grip()
		
func start_grip(surface: Object) -> void:
	gripper = PinJoint2D.new()
	gripper.node_a = self.get_path()
	gripper.node_b = surface.get_path()
	get_tree().current_scene.add_child(gripper)
	gripped = true
	
func end_grip() -> void:
	if gripper == null: return
	gripper.queue_free()
	gripped = false
