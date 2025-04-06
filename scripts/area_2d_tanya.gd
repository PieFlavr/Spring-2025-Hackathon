extends Area2D

@onready var conversation_menu: Control = %ConversationMenu
var interacted := false

func _on_body_entered(body: Node2D) -> void:
	var response = 0;
	if body.name == "Player" and not interacted:
		response = await conversation_menu.displayQuestion(
			"Help with the event or try to flirt?", 
			["Help (Z)", "Flirt (X)"], 
			"Tanya"
		)
		if response == 0 :
			conversation_menu.displayText("You help run Laser Chess! She gives you a badge.", "Tanya")
		elif response == 1 :
			conversation_menu.displayText("Bold move. She gives you her Golden Planner!","Tanya")

func _on_body_exited(body: Node2D) -> void:
	conversation_menu.closeMenu()
