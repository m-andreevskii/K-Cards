extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_back_button_pressed():
	MenuAudio.buttonPressedSound()
	#get_tree().change_scene_to_file("res://KCards/scenes/menu/main_menu.tscn")
	
	SceneTransition.change_buttons(self,"res://KCards/scenes/menu/MainMenuButtons.tscn")


func _on_offline_mode_button_pressed():
	MenuAudio.buttonPressedSound()
	#get_tree().change_scene_to_file("res://KCards/scenes/menu/difficulty_mode_menu.tscn")
	
	SceneTransition.change_buttons(self,"res://KCards/scenes/menu/difficulty_mode_menu.tscn")
	

