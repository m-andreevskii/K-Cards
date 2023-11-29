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

var scaleDeck = 0.12
var offsetXDeck = 44.5
var offsetYDeck = 51
var startingPosXDeck = 142
var startingPosYDeck = 338

var maxPages = CardsDatabase.DATA.size() / (rowsNum1 * collumnsNum1)
var currentPage = 0
var visibleCards = []

var deckCards = []

# Called when the node enters the scene tree for the first time.
func _ready():
	displayCards(currentPage)
	displayDeck()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_confirm_button_pressed():
	MenuAudio.buttonPressedSound()
	SceneTransition.change_buttons(self,"res://KCards/scenes/menu/difficulty_mode_menu.tscn")
	MenuAudio.changeBackgroundMusic("menu")


func _on_left_button_pressed():
	MenuAudio.buttonPressedSound()
	currentPage -= 1
	if currentPage < 0:
		currentPage = maxPages
	displayCards(currentPage)


func _on_right_button_pressed():
	MenuAudio.buttonPressedSound()
	currentPage += 1
	if currentPage > maxPages:
		currentPage = 0
	displayCards(currentPage)


func displayCards(page: int):
	removeCards()
	
	for i in range(0, rowsNum1):
		for j in range(0, collumnsNum1):
			var cardId = page * (rowsNum1 * collumnsNum1) + i * collumnsNum1 + j
			if (cardId > CardsDatabase.DATA.size() - 1):
				break
			
			var visibleCard = Card.instantiate()
			add_child(visibleCard)
			visibleCard.display_card(startingPosX+j*offsetX, startingPosY+i*offsetY, scale1, cardId, onCardSelected)
			visibleCards.append(visibleCard)


func displayDeck():
	removeDeck()
	
	var cardNum = 0
	for card in DeckManager.deck:
		var i = cardNum / collumnsNum2
		var j = cardNum % collumnsNum2
		
		var visibleCard = Card.instantiate()
		add_child(visibleCard)
		visibleCard.display_card(startingPosXDeck+j*offsetXDeck, startingPosYDeck+i*offsetYDeck, scaleDeck, card, onCardRemoved)
		deckCards.append(visibleCard)
		cardNum += 1


func removeCards():
	for card in visibleCards:
		remove_child(card)
	visibleCards.clear()


func removeDeck():
	for card in deckCards:
		remove_child(card)
	deckCards.clear()


func onCardSelected(index: int):
	MenuAudio.buttonPressedSound()
	DeckManager.addCard(index)
	displayDeck()


func onCardRemoved(index: int):
	MenuAudio.buttonPressedSound()
	DeckManager.removeCard(index)
	displayDeck()
