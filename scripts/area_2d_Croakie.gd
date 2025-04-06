#extends Area2D
#
#@onready var conversation_menu: Control = %ConversationMenu
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		#conversation_menu.displayQuestion("Test croakie", ["Two", "Three"], "Croakie")
		#
#
#
#
#
#
#func _on_body_exited(body: Node2D) -> void:
	#conversation_menu.closeMenu()
	#print("Now closing menu")
extends Area2D

@onready var conversation_menu: Control = %ConversationMenu
var interacted := false

func _on_body_entered(body: Node2D) -> void:
	var response = 0
	if body.name == "Player" and not interacted:
		response = await conversation_menu.displayQuestion(
			"Croak in sync or challenge to a hop race?",
			["Croak (Z)", "Hop Race (X)"],
			"Croakie"
		)
		if response == 0:
			conversation_menu.displayText("You croak in sync. Campus Fame +1!", "Croakie")
			Global.has_frog_token = true
		elif response == 1:
			if randf() > 0.5:
				conversation_menu.displayText("You won the hop race! Frog Token earned.", "Croakie")
				Global.has_frog_token = true
			else:
				conversation_menu.displayText("You fell in the fountain. Ouch.", "Croakie")
				Global.time_penalty(30)
		interacted = true

func _on_body_exited(body: Node2D) -> void:
	conversation_menu.closeMenu()
