extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound
@onready var coyote_timer = $CoyoteTimer


const SPEED = 100.0
const JUMP_VELOCITY = -285.0
var dead = false

func _physics_process(delta):
	if dead:
		velocity = Vector2.ZERO
		return
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	

	# Handle jump.
	if Input.is_action_just_pressed("jump") && (is_on_floor() || !coyote_timer.is_stopped()):
		velocity.y = JUMP_VELOCITY
		jump_sound.play() 
		
	var was_on_floor = is_on_floor()
		
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	
	# Move
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if was_on_floor && !is_on_floor() and not Input.is_action_pressed("jump"):
		coyote_timer.start()
