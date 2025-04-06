class_name TalkInteraction

extends Interactable

@export var dialogue_path : String

@onready var dialogue_resource = load(dialogue_path)

func on_interact():
	var dialogue_line = await dialogue_resource.get_next_dialogue_line("start")
	print(dialogue_line)
	pass
