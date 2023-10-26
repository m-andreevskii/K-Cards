extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_button_pressed():
	SceneTransition.change_scene("res://KCards/scenes/menu/main_menu.tscn")


