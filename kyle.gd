extends Area2D

@onready var label = $"Label"  # or $"DialogueBox/Label" if using a dialogue box

var interacted := false
var showing_choices := false

func _on_body_entered(body):
	if body.name == "Player" and not interacted:
		show_choices()

func show_choices():
	showing_choices = true
	label.text = "Ghost Kyle: Duel me in Smash?"

func _process(delta):
	if not showing_choices or interacted:
		return

	if Input.is_action_just_pressed("ui_accept"):
		label.text = "You defeat Ghost Kyle!"
		interacted = true
		showing_choices = false
