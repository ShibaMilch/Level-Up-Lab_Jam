extends Area2D
@onready var timer = $Timer
@onready var music = $"../GameMusic/AudioStreamPlayer"



func _on_body_entered(body):
	if body is CharacterBody2D:
		print("you won!")
		body.dead = true
		music.stop()
		$VictoryMusic.play()
		body.get_node("AnimatedSprite2D").play("victory")
		
		timer.start(4)


func _on_timer_timeout():
	$VictoryMusic.stop()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
