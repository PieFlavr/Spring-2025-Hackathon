"""
A generic interactable node.
"""

extends Area2D

@export var interact_name: String = ""
@export var interact_button = "ui_accept"
@export var interactable: bool = true

@export var interact: Callable = func():
	pass

#signal interacted
#
#func _process(delta):
	#if (interactable && Input.is_action_just_pressed(interact_button)):
		#emit_signal("interacted")
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		#interactable = true
#
#func _on_body_exited(body: Node2D) -> void:
	#if body.name == "Player":
		#interactable = false
