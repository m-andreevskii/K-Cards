extends Node2D

@onready 
var CardsDatabase = preload("res://KCards/cards/CardsDatabase.gd")
@onready
var myCardsDatabase = CardsDatabase.new()
@onready
var Cardname = $Bars/Name/CenterContainer/nameBackground/Name
@onready 
var CardImage

var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	display_card()
	pass
	
func display_card():
	var CardInfo = myCardsDatabase.DATA[index]
	
	var CardSize = $Button.size
	var type = CardInfo[1]
	if type == "Ability":
		$Button/Bars/BottomBar/Attack.visible = false
		$Button/Bars/BottomBar/Health.visible = false
	else: 
		$Button/Bars/BottomBar/Attack.visible = true
		$Button/Bars/BottomBar/Health.visible = true
	CardImage = str("res://KCards/images/card/card_images/", CardInfo[5])
	$Button/Background.scale = CardSize/$Button/Background.texture.get_size()
	#$Bars/Name/CenterContainer/nameBackground.scale *= CardSize/$Background.texture.get_size()
	$Button/Bars/Image.texture = load(CardImage)
	if ($Button/Bars/Image.texture != null):
		$Button/Bars/Image.scale = CardSize/($Button/Bars/Image.texture.get_size())

	if type != "Ability":
		var Attack = str(CardInfo[6])
		var Health = str(CardInfo[7])
		$Button/Bars/BottomBar/Attack/CenterContainer/attackBackground/Attack.text = Attack
		$Button/Bars/BottomBar/Health/CenterContainer/healthBackground/Health.text = Health

	var Cost = str(CardInfo[2]) 
	var Description = str(CardInfo[4])
	$Button/Bars/Name/CenterContainer/nameBackground/Name.text = CardInfo[3]
	$Button/Bars/TopBar/Cost/CenterContainer/costBackground/Cost.text = Cost
	$Button/Bars/Description/CenterContainer/descrBackground/Description.text = Description
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
"""@warning_ignore("unused_parameter")
func _process(delta):
	pass
"""


func _on_button_pressed():
	index+= 1
	if index >= 9:
		get_tree().quit()
	display_card()
	
