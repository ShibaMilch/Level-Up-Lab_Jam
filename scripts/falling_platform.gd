extends StaticBody2D

var time = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += 1
	$Sprite2D.position += Vector2(0, sin(time) * 2)


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		set_process(true)
		$Timer.start(0.7)


func _on_timer_timeout():
	queue_free()
