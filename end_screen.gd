extends Control
@onready var button_continue: Button = $CenterContainer/VBoxContainer/ButtonContinue
@onready var button_credits: Button = $CenterContainer/VBoxContainer/ButtonCredits


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_continue_pressed() -> void:
	button_continue.visible=false


func _on_button_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
