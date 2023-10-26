extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_exit_button_pressed():
	MenuAudio.buttonPressedSound()
	get_tree().quit()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_battles_button_pressed():
	MenuAudio.buttonPressedSound()
#	get_tree().change_scene_to_file("res://KCards/scenes/menu/mode_menu.tscn")


	get_node("FirstButton").queue_free()
	get_node("BattlesButton").queue_free()
	get_node("ExitButton").queue_free()
	get_node("CampaignButton").queue_free()
	
	var battleMenuButton = preload("res://KCards/scenes/menu/mode_menu.tscn")
	add_child(battleMenuButton.instantiate())
