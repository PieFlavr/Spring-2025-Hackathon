#extends Area2D
#
#@onready var conversation_menu: Control = %ConversationMenu
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		#conversation_menu.displayQuestion("Test kyle", ["Two", "Three"], "Kyle")
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
		var response: int = await conversation_menu.displayQuestion(
			"Challenge Ghost Kyle in Smash?",
			["Yes", "No"],
			"Kyle"
		)

		# Prevent double-trigger from closeMenu() or other causes
		if response == -1:
			return

		if response == 0:
			conversation_menu.displayText("You defeat Ghost Kyle!", "Kyle")
		elif response == 1:
			conversation_menu.displayText("You walk away... haunted.", "Kyle")

		interacted = true

func _on_body_exited(body: Node2D) -> void:
	conversation_menu.closeMenu()
