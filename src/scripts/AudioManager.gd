# AudioManager.gd
extends Node2D

# Referencia al AudioStreamPlayer
@onready var music_player = $temas/NivelDoodles
@onready var music_win = $temas/MenuYWin
@onready var sfx_no = $sfx/No
@onready var sfx_si = $sfx/Si

func play_win():
	if not music_win.playing:
		music_win.play()

func stop_win():
	if music_win.playing:
		music_win.stop() 


func play_music():
	if not music_player.playing:
		music_player.play()

func stop_music():
	if music_player.playing:
		music_player.stop()

func play_sfx_si():
	if not sfx_si.playing:
		sfx_si.play()

func play_sfx_no():
	if not sfx_no.playing:
		sfx_no.play()

func stop_sfx_si():
	if sfx_si.playing:
		sfx_si.stop()

func stop_sfx_no():
	if sfx_no.playing:
		sfx_no.stop()

func is_playing() -> bool:
	return music_player.playing
	
func is_playing_win() -> bool:
	return music_win.playing
