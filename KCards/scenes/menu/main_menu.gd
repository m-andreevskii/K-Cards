extends Node2D

func _on_exit_button_pressed():
	MenuAudio.buttonPressedSound()
	get_tree().quit()


func _on_battles_button_pressed():
	MenuAudio.buttonPressedSound()
	get_tree().change_scene_to_file("res://KCards/scenes/menu/mode_menu.tscn")
