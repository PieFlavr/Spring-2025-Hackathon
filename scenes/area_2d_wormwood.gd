extends Area2D

@onready var conversation_menu: Control = %ConversationMenu

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		conversation_menu.displayQuestion("Test wormwood", ["Two", "Three"], "Wormwood")
		





func _on_body_exited(body: Node2D) -> void:
	conversation_menu.closeMenu()
	print("Now closing menu")
