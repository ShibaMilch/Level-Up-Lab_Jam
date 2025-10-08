extends Node

func _ready():
	$MenuMusic.play()
	

func _on_play_pressed():
	$MenuMusic.stop()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
