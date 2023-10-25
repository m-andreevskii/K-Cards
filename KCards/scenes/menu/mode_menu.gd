extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_back_button_pressed():
	MenuAudio.buttonPressedSound()
	#get_tree().change_scene_to_file("res://KCards/scenes/menu/main_menu.tscn")
	
	get_node("BackButton").queue_free()
	get_node("OfflineModeButton").queue_free()
	get_node("OnlineModeButton").queue_free()
	
	var mainMenuButton = preload("res://KCards/scenes/menu/buttons_layer_2.tscn")
	add_child(mainMenuButton.instantiate())


func _on_offline_mode_button_pressed():
	MenuAudio.buttonPressedSound()
	#get_tree().change_scene_to_file("res://KCards/scenes/menu/difficulty_mode_menu.tscn")
	
	get_node("BackButton").queue_free()
	get_node("OfflineModeButton").queue_free()
	get_node("OnlineModeButton").queue_free()
	
	var difficultyMenuButton = preload("res://KCards/scenes/menu/difficulty_mode_menu.tscn")
	add_child(difficultyMenuButton.instantiate())
