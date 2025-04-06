extends CharacterBody2D

var interacted := false
var showing_choices := false
@onready var label = $DialogueBox/Label
@onready var conversation_menu: Control = $CanvasLayer/ConversationMenu

func _on_body_entered(body):
	print("Tanya1")
	if body.name == "Player" and not interacted:
		print("Tanya2")
		conversation_menu.displayQuestion(["One", "Two", "Three"])



func show_choices():
	showing_choices = true
	label.text = "Help event (Z) or Flirt (X)?"

func _process(delta):
	if not showing_choices or interacted:
		return

	if Input.is_action_just_pressed("ui_accept"):  # Z
		label.text = "You help run Laser Chess! She gives you a badge."
		Global.has_council_badge = true
		interacted = true
		showing_choices = false

	elif Input.is_action_just_pressed("ui_cancel"):  # X
		if randf() > 0.5:
			label.text = "Bold move. She gives you her Golden Planner!"
			Global.has_time_rewind = true
		else:
			label.text = "She rejects you on the campus PA system. Brutal."
			Global.time_penalty(30)
		interacted = true
		showing_choices = false
