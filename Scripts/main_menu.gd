extends Control
@onready var button_2: Button = $CenterContainer/VBoxContainer/Button2
@onready var button: Button = $CenterContainer/VBoxContainer/Button


## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_button_pressed() -> void:
	print("Im starting it")
	#get_tree().change_scene_to_file("res://Scenes/main.tscn")
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_button_2_pressed() -> void:
	button_2.visible=false




func _on_button_2_mouse_entered() -> void:
	button_2.text="leaf"


func _on_button_2_mouse_exited() -> void:
	button_2.text="leave"
