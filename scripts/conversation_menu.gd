
extends Control

@onready var option_button: OptionButton = $Menu/OptionButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func displayQuestion(questionList):
	option_button.clear()
	var index = 0
	for question in questionList:
		index += 1
		option_button.add_item(question)
		
	await option_button.item_selected
	
	return option_button.selected
