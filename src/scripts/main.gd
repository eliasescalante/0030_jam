extends Node2D

@onready var animacion = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_win()
	animacion.playback_active = true
	animacion.play("fondito")
	print(animacion.is_playing()) # debería decir "true"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not AudioManager.is_playing_win():
		AudioManager.play_win()

func _on_play_pressed() -> void:
	AudioManager.stop_win()
	get_tree().change_scene_to_file("res://src/scenes/level.tscn")

func _on_quit_button_up() -> void:
	get_tree().quit()

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/credits.tscn")
