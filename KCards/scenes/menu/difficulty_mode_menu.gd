extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_back_mode_button_pressed():
	MenuAudio.buttonPressedSound()
	#get_tree().change_scene_to_file("res://KCards/scenes/menu/mode_menu.tscn")
	
	get_node("BackModeButton").queue_free()
	get_node("EasyModeButton").queue_free()
	get_node("NormalModeButton").queue_free()
	get_node("EditingDeckButton").queue_free()
	
	var battleMenuButton = preload("res://KCards/scenes/menu/mode_menu.tscn")
	add_child(battleMenuButton.instantiate())
	


func _on_editing_deck_button_pressed():
	MenuAudio.buttonPressedSound()
	


func _on_easy_mode_button_pressed():
	MenuAudio.buttonPressedSound()


func _on_normal_mode_button_pressed():
	MenuAudio.buttonPressedSound()
