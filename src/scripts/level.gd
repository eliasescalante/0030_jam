extends Node2D

var sequence = []        # Secuencia que genera la máquina
var player_input = []    # Lo que presiona el jugador
var colors = ["red", "green", "blue", "yellow", "brown", "violette", "black", "pink", "gray", "orange"]
var score_hits := 0
var score_misses := 0
var game_time := 30.0 # segundos
var time_left: float



func _ready():
	AudioManager.play_music()
	time_left = game_time
	start_game()
	start_timer()

func _process(delta: float) -> void:
	
	if not AudioManager.is_playing():
		AudioManager.play_music()

	if time_left > 0:
		time_left -= delta
		$UX/time.text = str(round(time_left))
		if time_left < 0:
			time_left = 0
			$UX/time.text = str(round(time_left))
	else:
		end_game()

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
	$UX/Label.text = "RECUERDA BIEN..."
	var initial_delay := 0.5
	await get_tree().create_timer(initial_delay).timeout
	
	# Calculamos velocidad según el tiempo restante
	# Si quedan menos de 20 segundos (es decir, después del segundo 10), la secuencia va más rápido
	var highlight_time := 0.5
	var between_colors := 0.4
	# Aumentamos velocidad según el tiempo restante
	if time_left <= 25.0:   # después del segundo 10
		highlight_time = 0.2   # iluminar más rápido
		between_colors = 0.1   # menos espera entre colores
	elif time_left <= 10.0:  # después del segundo 20
		highlight_time = 0.15
		between_colors = 0.08
	
	
	
	
	for color_id in sequence:
		await highlight_button(color_id, highlight_time)
		await get_tree().create_timer(between_colors).timeout
	$UX/Label.text = "TU TURNO"

func highlight_button(color_id: int, duration: float = 0.5) -> void:
	var button = get_button_by_id(color_id)
	var original = button.modulate
	button.modulate = Color(2, 2, 2) # iluminar
	await get_tree().create_timer(duration).timeout
	button.modulate = original

func get_button_by_id(id: int) -> Node:
	match id:
		0: return $Buttons/ButtonRed
		1: return $Buttons/ButtonGreen
		2: return $Buttons/ButtonBlue
		3: return $Buttons/ButtonYellow
		4: return $Buttons/ButtonBrown
		5: return $Buttons/ButtonViolette
		6: return $Buttons/ButtonBlack
		7: return $Buttons/ButtonPink
		8: return $Buttons/ButtonGray
		9: return $Buttons/ButtonOrange
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
		$UX/Label.text = "FALLASTE"
		AudioManager.play_sfx_no()
		GameState.misses += 1
		await get_tree().create_timer(1).timeout
		
		#if sequence.size() == 1:
		player_input.clear()
		show_sequence()
		return
	
	if player_input[index] != sequence[index]:
		$UX/Label.text = "FALLASTE"
		AudioManager.play_sfx_no()
		GameState.misses += 1
		await get_tree().create_timer(1).timeout
		# Reinicia solo si es la primera instrucción
		#if sequence.size() == 1:
		player_input.clear()
		show_sequence()
		return

	if player_input.size() == sequence.size():
		$UX/Label.text = "¡ACERTASTE!"
		AudioManager.play_sfx_si()
		GameState.hits += 1
		await get_tree().create_timer(1).timeout
		add_new_step()

func start_timer():
	await get_tree().create_timer(game_time).timeout
	end_game()

func end_game():
	AudioManager.stop_music()
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

func _on_button_black_pressed() -> void:
	handle_input(6)

func _on_button_pink_pressed() -> void:
	handle_input(7)

func _on_button_gray_pressed() -> void:
	handle_input(8)

func _on_button_orange_pressed() -> void:
	handle_input(9)
