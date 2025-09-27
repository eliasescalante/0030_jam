extends Node2D

func _ready():
	$LabelHits.text = "Aciertos: %s" % GameState.hits
	$LabelMisses.text = "Errores: %s" % GameState.misses

func _process(delta: float) -> void:
	if not AudioManager.is_playing_win():
		AudioManager.play_win()
		
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/level.tscn")

func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/credits.tscn")
