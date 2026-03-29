extends Control
@onready var button_continue: Button = $CenterContainer/VBoxContainer/ButtonContinue
@onready var button_credits: Button = $CenterContainer/VBoxContainer/ButtonCredits


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_continue_pressed() -> void:
	button_continue.visible=false


func _on_button_credits_pressed() -> void:
	pass # Replace with function body.
