extends Node2D

@onready var global_audio: Node2D = $"."
@onready var music: AudioStreamPlayer = $music

var playing = false

func play() -> void:
	if not playing:
		#music.play();
		playing = true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playing = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
