extends CharacterBody2D
class_name Char2DSeg
@export_enum("Grip1","Grip2","Grip3","Grip4","Grip5")
var grip_action: String
@onready var pivot: Node2D = $Pivot
@onready var grip_ray: RayCast2D = $Pivot/Grip_ray
@export var grip_rays :Array[RayCast2D]
var slide = 10
var gripper: PinJoint2D
var gripped: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#pass

func _physics_process(delta: float) -> void:
	
	#print(velocity)
	
		
	if not is_on_floor():	
		velocity += get_gravity() * delta
#		print("grav")
		
	#SLIDE IF NOT GRIPPING change req
	if is_on_floor():
		var normal = get_floor_normal()
		var slide_dir = Vector2(normal.y, -normal.x).normalized()
	
		if slide_dir.dot(Vector2.DOWN) < 0:
			slide_dir = -slide_dir
		#velocity +=slide_dir*slide*delta
	if not gripped:
		move_and_slide()	
	if Input.is_action_pressed(grip_action) and not gripped:
		for ray in grip_rays:
			var surface = ray.get_collider()
			if surface != null: 
				if surface is not Char2DSeg: start_grip(surface)
	if Input.is_action_just_released(grip_action):
		end_grip()
		
func start_grip(surface: Object) -> void:
	#gripper = PinJoint2D.new()
	#gripper.node_a = self.get_path()
	#gripper.node_b = surface.get_path()
	#get_tree().current_scene.add_child(gripper)
	gripped = true
	
func end_grip() -> void:
	#if gripper == null: return
	#gripper.queue_free()
	gripped = false
	
func rotate_pivot(rot : float) -> void:
	pivot.rotation=rot
	
