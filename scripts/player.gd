extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sound = $JumpSound
@onready var coyote_timer = $CoyoteTimer
@onready var dust = preload("res://scenes/dust_particle.tscn")

const SPEED = 100.0
const JUMP_VELOCITY = -255.0
var dead = false
var jump_count = 0
var is_grounded = true

func _physics_process(delta):
	
	if is_grounded == false and is_on_floor() == true:
		var instance = dust.instantiate()
		instance.global_position = $Marker2D.global_position
		get_parent().add_child(instance)
	is_grounded = is_on_floor()
	
	if dead:
		velocity = Vector2.ZERO
		return

	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0

	# Handle jump
	if Input.is_action_just_pressed("jump") and (jump_count < 2 or !coyote_timer.is_stopped()):
		jump_count += 1
		if jump_count > 1:
			print("Double jumped!")
			animated_sprite.play("jump")
		velocity.y = JUMP_VELOCITY
		if jump_count < 2:
			jump_sound.play()

	var was_on_floor = is_on_floor()

	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()

	# Handle horizontal input
	var direction = Input.get_axis("move_left", "move_right")

	# Flip Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# --- Movement and crouch control ---
	if Input.is_action_pressed("crouch"):
		velocity.x = 0
	else:
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# --- Animation logic ---
	if is_on_floor():
		if Input.is_action_pressed("crouch"):
			play_animation("crouch")
		elif direction == 0:
			play_animation("idle")
		else:
			play_animation("run")
	else:
		play_animation("jump")

	# Start coyote timer when falling off a platform
	if was_on_floor and !is_on_floor() and not Input.is_action_pressed("jump"):
		coyote_timer.start()


func play_animation(anim_name: String):
	if animated_sprite.animation != anim_name:
		animated_sprite.play(anim_name)


func _on_AnimatedSprite2D_animation_finished():
	if animated_sprite.animation == "jump" and not is_on_floor():
		animated_sprite.frame = animated_sprite.sprite_frames.get_frame_count("jump") - 1
