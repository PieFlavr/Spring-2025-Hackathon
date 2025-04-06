#extends Area2D
#
#@onready var conversation_menu: Control = %ConversationMenu
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		#conversation_menu.displayQuestion("test question", ["Two", "Three"], "Tanya")
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
			

func _process(_delta: float) -> void:
	if interacted:
		return

	if Input.is_action_just_pressed("ui_accept"):  # Z
		conversation_menu.set_text("You help run Laser Chess! She gives you a badge.")
		Global.has_council_badge = true
		interacted = true

	elif Input.is_action_just_pressed("ui_cancel"):  # X
		if randf() > 0.5:
			conversation_menu.set_text("Bold move. She gives you her Golden Planner!")
			Global.has_time_rewind = true
		else:
			conversation_menu.set_text("She rejects you on the campus PA system. Brutal.")
			Global.time_penalty(30)
		interacted = true

func _on_body_exited(body: Node2D) -> void:
	conversation_menu.closeMenu()
