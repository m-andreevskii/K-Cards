extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_settings_button_pressed():
	MenuAudio.buttonPressedSound()
#	get_tree().change_scene_to_file("res://KCards/scenes/menu/main_menu.tscn")


	#SceneTransition.change_buttons(self,"res://KCards/scenes/menu/settings_menu.tscn")
	
	
	
	

