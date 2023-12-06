extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_move_button_pressed():
	MenuAudio.buttonPressedSound()
	SceneTransition.change_buttons(self,"res://KCards/scenes/menu/difficulty_mode_menu.tscn")
	MenuAudio.changeBackgroundMusic("menu")
	pass
