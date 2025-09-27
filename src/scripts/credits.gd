extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_win()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not AudioManager.is_playing_win():
		AudioManager.play_win()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main.tscn")
	pass # Replace with function body.
