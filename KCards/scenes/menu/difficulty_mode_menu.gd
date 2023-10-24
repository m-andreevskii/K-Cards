extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_back_mode_button_pressed():
	get_tree().change_scene_to_file("res://KCards/scenes/menu/mode_menu.tscn")
