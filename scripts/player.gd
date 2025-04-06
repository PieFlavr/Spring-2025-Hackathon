extends CharacterBody2D

@export var speed: float = 200.0
@export var dash_speed: float = 600.0
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.5

# Node Access Variables
@onready var anim_sprite = $AnimatedSprite2D

# State Variables
var state = states.idle
var prev_state = -1

enum states {
	idle,
	walk,
	dash,
	act,
} # for managing interaction and dialouge -L

var input_vector = Vector2.ZERO

# initializing
var can_dash = true
var dash_timer = 0.0
var dash_direction = Vector2.ZERO

func check_state():
	# if not acting, do anything else
	if(state == states.act):
		update_state(state)
	elif(state != states.dash):
		# moved input vector checking to state_check event to avoid _prcoess() nastiness -L
		input_vector = Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		).normalized()
		# if pressing any movement keys and not walking, walk -L
		if(input_vector != Vector2.ZERO && state != states.walk):
			update_state(states.walk)
		# if walking, and not movement keys, idle -L
		elif (input_vector == Vector2.ZERO && state == states.walk):
			update_state(states.idle)
		# if walking, and pressed dash, then dash -L
		elif((state == states.walk && Input.is_action_just_pressed("dash") && can_dash)
			&& (dash_timer <= 0.0)):
			update_state(states.dash)
		else:
			update_state(state)
	else:
		update_state(state)
	
func _physics_process(delta):
	check_state()
	
	if(prev_state != state): 
		print("State transition ", prev_state, " to ", state)
	
	match(state): #process state
		states.idle:
			do_idle_state(prev_state, delta)
		states.walk:
			do_walk_state(prev_state, delta)
		states.dash:
			do_dash_state(prev_state, delta)
		states.act:
			do_act_state(prev_state,delta)
			
#region STATE TRANSITION FUNCTIONs
func do_idle_state(prev_state: int, delta: float):
	transition_animation("idle")

func do_walk_state(prev_state: int, delta: float):
	transition_animation("walk")
	if abs(input_vector.x) > abs(input_vector.y):
		anim_sprite.flip_h = input_vector.x < 0
	velocity = input_vector * speed 
	
	move_and_slide() # process movement

func do_dash_state(prev_state: int, delta: float):
	transition_animation("dash")
	
	if(prev_state != states.dash): #perform transition stuff -L
		can_dash = false
	
	velocity = input_vector * dash_speed
	move_and_slide() # process movement -L
	dash_timer += delta
	
	if dash_timer >= dash_duration:
		can_dash = true
		dash_timer = 0
		update_state(states.walk)

func do_act_state(prev_state: int, delta: float):
	transition_animation("idle")
		
func transition_animation(animation_name: String):
	if(anim_sprite.is_playing() && anim_sprite.animation != animation_name):
		anim_sprite.play(animation_name)
#endregion

#region CONVERSATION ACT LOCK FUNCTIONs
func _on_conversation_menu_lock_controls() -> void:
	update_state(states.act)

func _on_conversation_menu_unlock_controls() -> void:
	update_state(states.idle)

func update_state(new_state: int):
	prev_state = state
	state = new_state
#endregion
