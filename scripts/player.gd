extends CharacterBody2D

@export var speed: float = 200.0
@export var dash_speed: float = 800.0
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.5

var is_dashing = false
var can_dash = true
var dash_timer = 0.0
var dash_direction = Vector2.ZERO

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	# Handle dash
	if is_dashing:
		velocity = dash_direction * dash_speed
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	else:
		velocity = input_vector * speed
		if Input.is_action_just_pressed("dash") and can_dash and input_vector != Vector2.ZERO:
			start_dash(input_vector)

	move_and_slide()

	# Animation logic
	var anim_sprite = $AnimatedSprite2D

	if is_dashing:
		# Optional: play dash animation or keep current
		anim_sprite.play("dash")
	elif input_vector == Vector2.ZERO:
		anim_sprite.stop()
	else:
		if abs(input_vector.x) > abs(input_vector.y):
			anim_sprite.play("walk_right")
			anim_sprite.flip_h = input_vector.x < 0
		else:
			anim_sprite.play("walk_down" if input_vector.y > 0 else "walk_up")

func start_dash(direction: Vector2):
	is_dashing = true
	can_dash = false
	dash_direction = direction
	dash_timer = dash_duration

	# Start cooldown as a timer using coroutine
	await get_tree().create_timer(dash_cooldown).timeout
	can_dash = true
