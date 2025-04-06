extends Control

@onready var option_button: OptionButton = $Menu/OptionButton
@onready var character_texture: TextureRect = $"Character Texture"
@onready var question_text: RichTextLabel = $Menu/QuestionText
@onready var character_name: RichTextLabel = $Menu/CharacterName

signal lock_controls
signal unlock_controls

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func displayText(text, characterName):
	visible = true
	
	question_text.text = text
	character_name.text = characterName + ":"
	
	load_character(characterName)
	
	option_button.clear()
	option_button.visible = false

func displayQuestion(question, answerList, characterName):
	
	visible = true
	option_button.visible = true
	lock_controls.emit()
	
	question_text.text = question
	character_name.text = characterName + ":"
	
	load_character(characterName)
	
	option_button.clear()
	var index = 0
	for answer in answerList:
		index += 1
		option_button.add_item(answer)
		
	await option_button.item_selected
	
	print("Selected " + str(option_button.selected))
	
	unlock_controls.emit()
	visible = false
	
	return option_button.selected
	
func closeMenu():
	visible = false
	
# just for easier encapsulation
func load_character(character_name: String):
	match character_name:
		"Croakie":
			character_texture.texture = load("res://Assets/Character_Art/Croakie.png")
		"Kyle":
			character_texture.texture = load("res://Assets/Character_Art/Kyle.png")
		"Riley":
			character_texture.texture = load("res://Assets/Character_Art/Riley.png")
		"Tanya":
			character_texture.texture = load("res://Assets/Character_Art/Tanya.png")
		"Wormwood":
			character_texture.texture = load("res://Assets/Character_Art/Wormwood.png")
		_:
			character_texture.visible = false
