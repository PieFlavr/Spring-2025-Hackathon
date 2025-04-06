extends CharacterBody2D

@export var speed: float = 200.0

func _physics_process(delta):
	var input_vector = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = input_vector * speed
	move_and_slide()
	
	var anim_sprite = $AnimatedSprite2D

	if input_vector == Vector2.ZERO:
		anim_sprite.stop()
	else:
		if abs(input_vector.x) > abs(input_vector.y):
			anim_sprite.play("walk_right")
			if input_vector.x > 0:
				anim_sprite.flip_h = false
			else:
				anim_sprite.flip_h = true
		else:
			anim_sprite.play("walk_down" if input_vector.y > 0 else "walk_up")
