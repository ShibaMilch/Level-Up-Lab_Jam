extends StaticBody2D

var time = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.visible == true:
		time += 1
		$Sprite2D.position += Vector2(0, sin(time) * 2)
	


func _on_area_2d_body_entered(body):
	if body.name == 'Player' and self.visible == true:
		set_process(true)
		print("yes")
		$Timer.start(0.7)
		$RespawnTimer.start(5)


func _on_timer_timeout():
	self.visible = false
	$BlockCollision.disabled = true
	set_process(false)


func _on_respawn_timer_timeout():
	self.visible = true
	$BlockCollision.disabled = false
