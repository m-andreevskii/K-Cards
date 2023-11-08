extends MarginContainer

@onready 
var CardsDatabase = preload("res://KCards/cards/CardsDatabase.gd")
@onready
var myCardsDatabase = CardsDatabase.new()
@onready
var Cardname = $Bars/Name/CenterContainer/nameBackground/Name
@onready 
var CardImage


# Called when the node enters the scene tree for the first time.
func _ready():
	
	Cardname = "Scarecrew"
	var CardInfo = CardsDatabase.DATA[myCardsDatabase.get(Cardname)]
	var CardSize = size
	var Attack = str(CardInfo[2])
	var Health = str(CardInfo[3])
	var Cost = str(CardInfo[4]) 
	var Description = str(CardInfo[6])
	CardImage = str("res://KCards/images/card/card_images/", CardInfo[7])
	$Background.scale *= CardSize/$Background.texture.get_size()
	$Bars/Name/CenterContainer/nameBackground.scale *= CardSize/$Background.texture.get_size()
	$Bars/Image.texture = load(CardImage)
	if ($Bars/Image.texture != null):
		$Bars/Image.scale *= CardSize/($Bars/Image.texture.get_size())

	$Bars/Name/CenterContainer/nameBackground/Name.text = CardInfo[5]
	$Bars/TopBar/Cost/CenterContainer/costBackground/Cost.text = Cost
	$Bars/Description/CenterContainer/descrBackground/Description.text = Description
	$Bars/BottomBar/Attack/CenterContainer/attackBackground/Attack.text = Attack
	$Bars/BottomBar/Health/CenterContainer/healthBackground/Health.text = Health

# Called every frame. 'delta' is the elapsed time since the previous frame.
"""@warning_ignore("unused_parameter")
func _process(delta):
	pass
"""
