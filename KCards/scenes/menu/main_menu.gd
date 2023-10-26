extends Node2D
"""
func _on_exit_button_pressed():
	get_tree().quit()
	"""
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var battleMenuButton = preload("res://KCards/scenes/menu/MainMenuButtons.tscn")
	add_child(battleMenuButton.instantiate())

	
