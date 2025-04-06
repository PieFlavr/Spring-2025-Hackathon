extends Area2D

@onready var conversation_menu: Control = %ConversationMenu

func _on_body_entered(body: Node2D) -> void:
	print("Tanya1")
	if body.name == "Player":
		print("Tanya2")
		conversation_menu.displayQuestion(["One", "Two", "Three"])
		



func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	conversation_menu.visible = false
