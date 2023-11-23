extends CanvasLayer
var Card = preload("res://KCards/scenes/card_base.tscn")


var offsetX = 125
var offsetY = 146
var scale1 = 0.34
var startingPosX = 125
var startingPosY = 50

var rowsNum1 = 2
var collumnsNum1 = 4
var rowsNum2 = 2		# for player's deck
var collumnsNum2 = 10	# for player's deck

# Called when the node enters the scene tree for the first time.
func _ready():
	# function loads 8 cards on the screen...
	var visibleCard = null
	for i in range(0, rowsNum1):
		for j in range(0, collumnsNum1):
			#print(i, "/", j)
			visibleCard = Card.instantiate()
			add_child(visibleCard)
			visibleCard.display_card(startingPosX+j*offsetX, startingPosY+i*offsetY, scale1, collumnsNum1*i+j)
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



func _on_right_button_pressed():
	MenuAudio.buttonPressedSound()


func _on_line_edit_text_changed(new_text):
	pass # Replace with function body.
