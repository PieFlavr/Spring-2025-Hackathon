#extends Area2D
#
#@onready var conversation_menu: Control = %ConversationMenu
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		#conversation_menu.displayQuestion("Test wormwood", ["Two", "Three"], "Wormwood")
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
	if body.name == "Player" and not interacted:
		var response = await conversation_menu.displayQuestion(
			"Give sandwich or debate?", 
			["Give Sandwich (Z)", "Debate (X)"], 
			"Wormwood"
		)

		if response == 0:
			conversation_menu.displayText("He blesses you with a map!", "Wormwood")
			Global.has_map = true
		elif response == 1:
			if randf() > 0.5:
				conversation_menu.displayText("You failed the debate. Lost time!", "Wormwood")
				#Global.time_penalty(60)
			else:
				conversation_menu.displayText("You won the debate! You gain wisdom.", "Wormwood")
				Global.has_map = true

		interacted = true

func _on_body_exited(body: Node2D) -> void:
	conversation_menu.closeMenu()
	print("Now closing menu")
