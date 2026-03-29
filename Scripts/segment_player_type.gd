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

func _physics_process(delta: float) -> void:
	
#	if grip_action=="Grip1":
		#print(velocity)
	
		
	if not is_on_floor():
		velocity += (get_gravity()/2) * delta
		if not get_parent().some_grip():
			velocity += get_parent().saved_velocity * delta
		#print(velocity)
		
	#SLIDE IF NOT GRIPPING change req
	if is_on_floor():
		var normal = get_floor_normal()
		var floor_vector = Vector2(normal.y, -normal.x).normalized()
		#print(rad_to_deg(normal.angle_to(Vector2.UP)))
		
		if abs(rad_to_deg(normal.angle_to(Vector2.UP)))>=30:
			var des = sign(rad_to_deg(normal.angle_to(Vector2.UP)))
			velocity +=floor_vector*slide*des
		

	if Input.is_action_pressed(grip_action) and not gripped:
		for ray in grip_rays:
			var surface = ray.get_collider()
			if surface != null: 
				if surface is not Char2DSeg:
					if surface is Ungrippable: continue
					start_grip(surface)
	if Input.is_action_just_released(grip_action):
		end_grip()
		
	if Input.is_action_just_pressed("blows up"):
		velocity += Vector2(randf_range(-10000, 10000), randf_range(-10000, 10000))
		
	if not gripped:
		move_and_slide()		
			
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
	
