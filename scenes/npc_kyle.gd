extends Area2D

var interacted := false
var showing_choices := false
@onready var label = $DialogueBox/Label

func _on_body_entered(body):
	if body.name == "Player" and not interacted:
		show_choices()

func show_choices():
	showing_choices = true
	label.text = "Ghost Kyle: Duel me in Smash (Z) or Run Away (X)?"

func _process(delta):
	if not showing_choices or interacted:
		return

	if Input.is_action_just_pressed("ui_accept"):  # Z
		label.text = "You defeat Ghost Kyle in a Smash battle. He vanishes in peace..."
		Global.has_ghost_slayer_title = true
		interacted = true
		showing_choices = false

	elif Input.is_action_just_pressed("ui_cancel"):  # X
		label.text = "Ghost Kyle haunts your dreams. -30 seconds!"
		Global.time_penalty(30)
		interacted = true
		showing_choices = false
