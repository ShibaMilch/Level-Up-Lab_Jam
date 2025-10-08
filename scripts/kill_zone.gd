extends Area2D

@onready var timer = $Timer
@onready var death_sound = $DeathSound
var effect = AudioServer.get_bus_effect(1, 0)
@onready var audio_stream_player = $"../../GameMusic/AudioStreamPlayer"


func _on_body_entered(body):
	if body is CharacterBody2D and body.dead == false:
		print("You Died!")
		death_sound.play()
		
		body.dead = true
		body.get_node("CollisionShape2D").disabled = true
		effect.pitch_scale = 0.5
		body.get_node("AnimatedSprite2D").play("death")
		

		Engine.time_scale = 0.5
		timer.start()
	

func _on_timer_timeout():
	Engine.time_scale = 1.0
	effect.pitch_scale = 1.0
	get_tree().reload_current_scene()
