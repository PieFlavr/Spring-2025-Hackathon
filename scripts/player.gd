extends CharacterBody2D

@export var speed: float = 200.0
@export var dash_speed: float = 600.0
@export var dash_duration: float = 0.2
@export var dash_cooldown: float = 0.5

# Node Access Variables
var anim_sprite

# State Variables
var state = states.idle
var prev_state = -1

enum states {
	idle,
	walk,
	dash,
	act,
} # for managing interaction and dialouge -L

var input_vector = Vector2()

# initializing
var can_dash = true
var dash_timer = 0.0
var dash_direction = Vector2.ZERO

func _ready() -> void:
	anim_sprite = $AnimatedSprite2D

func check_state():
	prev_state = state
	# if not acting, do anything else
	if(state != states.act && state != states.dash):
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
			state = states.idle
		# if walking, and pressed dash, then dash -L
		elif((state == states.walk && Input.is_action_just_pressed("dash") && can_dash)
			&& (dash_timer <= 0.0)):
			state = states.dash
	
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
			

func do_idle_state(prev_state: int, delta: float):
	if(prev_state != states.idle):
		anim_sprite.play("idle")

func do_walk_state(prev_state: int, delta: float):
	if(prev_state != states.walk):
		if abs(input_vector.x) > abs(input_vector.y):
			anim_sprite.play("walk_right")
			anim_sprite.flip_h = input_vector.x < 0
		else:
			anim_sprite.play("walk_down" if input_vector.y > 0 else "walk_up")
	velocity = input_vector * speed 
	
	move_and_slide() # process movement
	
func do_dash_state(prev_state: int, delta: float):
	if(prev_state != states.dash): #perform transition stuff -L
		update_state(states.dash)
		can_dash = false
	
	velocity = input_vector * dash_speed
	move_and_slide() # process movement -L
	dash_timer += delta
	
	if dash_timer >= dash_duration:
		can_dash = true
		dash_timer = 0
		update_state(states.walk)
		
func do_act_state(prev_state: int, delta: float):
	if(prev_state != states.act):
		anim_sprite.play("idle")
		print("Now Acting!")

"""
CONVERSATION/ACT LOCK FUNCTION OVERRIDES
"""
func _on_conversation_menu_lock_controls() -> void:
	update_state(states.act)
	
func _on_conversation_menu_unlock_controls() -> void:
	update_state(states.idle)

func update_state(new_state: int):
	prev_state = state
	state = new_state
	
