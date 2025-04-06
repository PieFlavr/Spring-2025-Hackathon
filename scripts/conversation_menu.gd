
extends Control

@onready var option_button: OptionButton = $Menu/OptionButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func displayQuestion(questionList):
	print("Test")
	
	visible = true
	option_button.clear()
	var index = 0
	for question in questionList:
		index += 1
		option_button.add_item(question)
		
	await option_button.item_selected
	
	visible = false
	
	return option_button.selected
