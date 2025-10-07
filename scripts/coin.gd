extends Area2D

@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func spawn_feedback():
	var scene_to_spawn = preload("res://scenes/feedback.tscn")
	var new_scene_instance = scene_to_spawn.instantiate()
	get_tree().current_scene.add_child(new_scene_instance)  # Add the instance as a child of the current scene
	new_scene_instance.global_position = global_position

func _on_body_entered(body):
	if body is CharacterBody2D:
		game_manager.add_point()
		spawn_feedback()
		animation_player.play("pickup")
		
