#extends Area2D
#
#var interacted := false
#@onready var label = $DialogueBox/Label
#
#func _on_body_entered(body):
	#if body.name == "Player" and not interacted:
		#show_choices()
#
#func show_choices():
	#label.text = "Give sandwich (Z) or debate (X)?"
	#if Input.is_action_pressed("ui_accept"):  # sandwich
		#label.text = "He blesses you with a map!"
		#Global.has_map = true
		#interacted = true
	#elif Input.is_action_pressed("ui_cancel"):  # debate
		#if randf() > 0.5:
			#label.text = "You failed the debate. Lost time!"
			#Global.time_penalty(60)
		#else:
			#label.text = "You won the debate! You gain wisdom."
			#Global.has_map = true
		#interacted = true


extends Area2D

var interacted := false
var showing_choices := false
@onready var label = $DialogueBox/Label

func _on_body_entered(body):
	if body.name == "Player" and not interacted:
		show_choices()

func show_choices():
	showing_choices = true
	label.text = "Give sandwich (Z) or Debate (X)?"

func _process(delta):
	if not showing_choices or interacted:
		return

	if Input.is_action_just_pressed("ui_accept"):  # Z key
		label.text = "He blesses you with a map!"
		Global.has_map = true
		interacted = true
		showing_choices = false

	elif Input.is_action_just_pressed("ui_cancel"):  # X key
		if randf() > 0.5:
			label.text = "You failed the debate. Lost time!"
			Global.time_penalty(60)
		else:
			label.text = "You won the debate! You gain wisdom."
			Global.has_map = true
		interacted = true
		showing_choices = false
