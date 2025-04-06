extends Area2D

@onready var conversation_menu: Control = %ConversationMenu

func _on_body_entered(body: Node2D) -> void:
	print("Tanya1")
	if body.name == "Player":
		print("Tanya2")
		conversation_menu.displayQuestion(["Two", "Three"])
		





func _on_body_exited(body: Node2D) -> void:
	conversation_menu.closeMenu()
	print("Now closing menu")
