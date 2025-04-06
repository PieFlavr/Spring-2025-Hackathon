extends Area2D

var interacted := false
var showing_choices := false
@onready var label = $DialogueBox/Label

func _on_body_entered(body):
	if body.name == "Player" and not interacted:
		show_choices()

func show_choices():
	showing_choices = true
	label.text = "Croak (Z) or Hop Race (X)?"

func _process(delta):
	if not showing_choices or interacted:
		return

	if Input.is_action_just_pressed("ui_accept"):  # Z
		label.text = "You croak in sync. Campus Fame +1!"
		Global.has_frog_token = true
		interacted = true
		showing_choices = false

	elif Input.is_action_just_pressed("ui_cancel"):  # X
		if randf() > 0.5:
			label.text = "You won the hop race! Frog Token earned."
			Global.has_frog_token = true
		else:
			label.text = "You fell in the fountain. Ouch."
			Global.time_penalty(30)
		interacted = true
		showing_choices = false
