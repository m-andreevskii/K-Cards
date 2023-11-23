extends CanvasLayer
var Card = preload("res://KCards/scenes/card_base.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var visibleCard = null
	for i in range(0, 2):
		for j in range(0, 4):
			print(i, "/", j)
			visibleCard = Card.instantiate()
			add_child(visibleCard)
			visibleCard.display_card(125+j*125,50+i*146, 0.34, 4*i+j)
	#card.display_card()
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_confirm_button_pressed():
	MenuAudio.buttonPressedSound()
	SceneTransition.change_buttons(self,"res://KCards/scenes/menu/difficulty_mode_menu.tscn")
	MenuAudio.changeBackgroundMusic("menu")


func _on_left_button_pressed():
	MenuAudio.buttonPressedSound()
	var displayCards = CardDisplay.new()


func _on_right_button_pressed():
	MenuAudio.buttonPressedSound()


func _on_line_edit_text_changed(new_text):
	pass # Replace with function body.
