extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	# loading config settings: 
	if(Config.getConfigValue("graphics", "is_fullscreen")):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	
	var volumeValue = Config.getConfigValue("audio", "music_volume")
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(volumeValue))
	
	pass # Replace with function body.


func _on_button_pressed():
	SceneTransition.change_scene("res://KCards/scenes/menu/main_menu.tscn")


