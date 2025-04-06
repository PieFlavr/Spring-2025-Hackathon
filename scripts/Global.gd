extends Node

var has_map = false
var has_usb = false
var has_frog_token = false
var has_bad_ui = false
var has_art_token: bool = false

func time_penalty(seconds):
	var main = get_tree().get_root().get_node("Main")
	if main.has_method("apply_time_penalty"):
		main.apply_time_penalty(seconds)
var has_ghost_slayer_title = false

#extends Node
#
#var has_map = false
#var has_usb = false
#var has_frog_token = false
#var has_bad_ui = false
#
#func time_penalty(seconds):
	#var main = get_tree().get_root().get_node("Main")
	#if main.has_method("apply_time_penalty"):
		#main.apply_time_penalty(seconds)
#var has_ghost_slayer_title = false
