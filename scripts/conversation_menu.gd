
extends Control

@onready var option_button: OptionButton = $Menu/OptionButton
@onready var character_texture: TextureRect = $"Character Texture"
@onready var question_text: RichTextLabel = $Menu/QuestionText
@onready var character_name: RichTextLabel = $Menu/CharacterName

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	#$CanvasLayer.gui_disable_input = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func displayText(text, characterName):
	visible = true
	
	question_text.text = text
	character_name.text = characterName + ":"
	
	if characterName == "Croakie":
		character_texture.texture = load("res://Assets/Character_Art/Croakie.png")
	elif characterName == "Kyle":
		character_texture.texture = load("res://Assets/Character_Art/Kyle.png")
	elif characterName == "Riley":
		character_texture.texture = load("res://Assets/Character_Art/Riley.png")
	elif characterName == "Tanya":
		character_texture.texture = load("res://Assets/Character_Art/Tanya.png")
	elif characterName == "Wormwood":
		character_texture.texture = load("res://Assets/Character_Art/Wormwood.png")
	else:
		character_texture.visible = false
	
	option_button.clear()
	option_button.visible = false



func displayQuestion(question, answerList, characterName):
	
	visible = true
	option_button.visible = true
	
	question_text.text = question
	character_name.text = characterName + ":"
	
	if characterName == "Croakie":
		character_texture.texture = load("res://Assets/Character_Art/Croakie.png")
	elif characterName == "Kyle":
		character_texture.texture = load("res://Assets/Character_Art/Kyle.png")
	elif characterName == "Riley":
		character_texture.texture = load("res://Assets/Character_Art/Riley.png")
	elif characterName == "Tanya":
		character_texture.texture = load("res://Assets/Character_Art/Tanya.png")
	elif characterName == "Wormwood":
		character_texture.texture = load("res://Assets/Character_Art/Wormwood.png")
	else:
		character_texture.visible = false
	
	option_button.clear()
	var index = 0
	for answer in answerList:
		index += 1
		option_button.add_item(answer)
		
	await option_button.item_selected
	
	print("Selected " + str(option_button.selected))
	
	visible = false
	
	return option_button.selected
	
func closeMenu():
	visible = false
	
