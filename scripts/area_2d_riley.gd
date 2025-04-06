#extends Area2D
#
#@onready var conversation_menu: Control = %ConversationMenu
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		#conversation_menu.displayQuestion("Test riley", ["Two", "Three"], "Riley")
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
			"Compliment Riley's art or challenge her to a speed-paint duel?",
			["Compliment (Z)", "Speed-Paint Duel (X)"],
			"Riley"
		)
		if response == 0:
			conversation_menu.displayText("She smiles and gives you a sketch of yourself. Nice!", "Riley")
			Global.has_art_token = true
		elif response == 1:
			if randf() > 0.5:
				conversation_menu.displayText("You crushed it! Riley respects your style.", "Riley")
				Global.has_art_token = true
			else:
				conversation_menu.displayText("Yikes, spilled ink everywhere. Riley is not impressed.", "Riley")
				Global.time_penalty(30)
		interacted = true

func _on_body_exited(body: Node2D) -> void:
	conversation_menu.closeMenu()
