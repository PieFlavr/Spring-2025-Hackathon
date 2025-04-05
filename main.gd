extends Node

@export var total_time := 300  # 5 minutes
var time_left := total_time

@onready var timer_label = $CanvasLayer/TimerLabel

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		time_left = 0
		game_over()
	timer_label.text = "Time Left: " + str(ceil(time_left))

func game_over():
	get_tree().change_scene_to_file("res://EndScreen.tscn")


func _on_npc_wormwood_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
#func _on_npc_wormwood_body_entered(body: Node2D) -> void:
	#pass # Replace with function body.
