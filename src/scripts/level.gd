extends Node2D

var sequence = []        # Secuencia que genera la máquina
var player_input = []    # Lo que presiona el jugador
var colors = ["red", "green", "blue", "yellow", "brown", "violette"]
var score_hits := 0
var score_misses := 0
var game_time := 30.0 # segundos


func _ready():
	start_game()
	start_timer()

func start_game():
	sequence.clear()
	player_input.clear()
	add_new_step()

func add_new_step():
	var random_color = randi() % colors.size()
	sequence.append(random_color)
	show_sequence()

func show_sequence() -> void:
	player_input.clear()
	$UX/Label.text = "Simón dice..."
	await get_tree().create_timer(1).timeout
	for color_id in sequence:
		await highlight_button(color_id)
		await get_tree().create_timer(0.4).timeout
	$UX/Label.text = "Tu turno"

func highlight_button(color_id: int) -> void:
	var button = get_button_by_id(color_id)
	var original = button.modulate
	button.modulate = Color(2, 2, 2) # iluminar
	await get_tree().create_timer(0.5).timeout
	button.modulate = original

func get_button_by_id(id: int) -> Node:
	match id:
		0: return $Buttons/ButtonRed
		1: return $Buttons/ButtonGreen
		2: return $Buttons/ButtonBlue
		3: return $Buttons/ButtonYellow
		4: return $Buttons/ButtonBrown
		5: return $Buttons/ButtonViolette
		_: return null

# -----------------------------
# Input del jugador
# -----------------------------
func handle_input(id: int):
	var button = get_button_by_id(id)
	await highlight_button(id) # efecto al clickear
	player_input.append(id)

	var index = player_input.size() - 1
	
	if index >= sequence.size():
		$UX/Label.text = "¡Fallaste!"
		GameState.misses += 1
		return
	
	if player_input[index] != sequence[index]:
		$UX/Label.text = "¡Fallaste!"
		GameState.misses += 1
		return

	if player_input.size() == sequence.size():
		$UX/Label.text = "¡Bien hecho!"
		GameState.hits += 1
		await get_tree().create_timer(1).timeout
		add_new_step()

func start_timer():
	await get_tree().create_timer(game_time).timeout
	end_game()

func end_game():
	get_tree().change_scene_to_file("res://src/scenes/WinLose.tscn")

# -----------------------------
# Señales de los botones
# -----------------------------
func _on_button_red_pressed():
	handle_input(0)

func _on_button_green_pressed():
	handle_input(1)

func _on_button_blue_pressed():
	handle_input(2)

func _on_button_yellow_pressed():
	handle_input(3)

func _on_button_brown_pressed():
	handle_input(4)

func _on_button_violette_pressed():
	handle_input(5)
