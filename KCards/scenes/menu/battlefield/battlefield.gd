extends Node

var Card = preload("res://KCards/scenes/card_baseForBattle.tscn")
var deck = []
var deckMaxSize = 20
var playerHand = []
var playerHandVision = []
var passedCard = []
var playableCard = []
var CardIndex = 0
var MaxCardInDeck = 19
var SelectedCard = null
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var file = FileAccess.open("user://" + "deck.txt", FileAccess.READ)
	deck.clear()
	var str
	while !file.eof_reached():
		str = file.get_line()
		if str == "END":
			break
		else:
			deck.append(int(str))
			if deck.size() > deckMaxSize:
				deck.remove_at(0)
			saveFile()
	deck.shuffle()
	playableCard = deck
	drawCards(CardIndex,5)
	print(playerHand)
	displayHand()
	# Replace with function body.
func drawCards(start_of_hand: int, count: int):
	
	for index in range(start_of_hand, start_of_hand + count):
		print(index)
		CardIndex = CardIndex + 1
		playerHand.append(playableCard[index])
		if CardIndex > MaxCardInDeck:
			CardIndex = 0
			playableCard.shuffle()
			break
	

func displayHand():
	var j = 0
	for i in playerHand:
		var visibleCard = Card.instantiate()
		add_child(visibleCard)
		visibleCard.display_card(200+j*70, 440, 0.27, i, onCardSelect)
		j = j + 1
		playerHandVision.append(visibleCard)
	j = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	pass


func _on_move_button_pressed():
	playerHand.clear()
	for x in playerHandVision:
		x.queue_free()
	playerHandVision.clear()
	drawCards(CardIndex,5)
	
	displayHand()
	pass

func saveFile():
	var file = FileAccess.open("user://" + "deck.txt", FileAccess.WRITE_READ)
	for card in deck:
		file.store_line(str(card))
	file.store_line("END")

func onCardSelect(CardName: String):
	print(CardName)
	SelectedCard = CardName
	
	$Table/CardSlotsGlow.play("Glows")
	
