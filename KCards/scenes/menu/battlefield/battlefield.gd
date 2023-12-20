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

var deckAI = []
var cellAIDeck = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
var freeCellAIDeck = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

var selectedCard = null
var outerCircleCardNames = []
var innerCircleCardNames = []
var numberOfCardsInCircle = 12
var cardScaleOnTable = 0.14
var CardInfo = CardsDatabase

# Called when the node enters the scene tree for the first time.
func _ready():
	outerCircleCardNames.resize(numberOfCardsInCircle)
	outerCircleCardNames.fill("")
	innerCircleCardNames.resize(numberOfCardsInCircle)
	innerCircleCardNames.fill("")
	
	
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

	displayHand()
	generateAICard()
	
	
	
	
	
func drawCards(start_of_hand: int, count: int):
	
	for index in range(start_of_hand, start_of_hand + count):
		
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
		visibleCard.display_card(200+j*70, 440, 0.27, i, cardActions)
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
	moveAI()
	
	pass

func saveFile():
	var file = FileAccess.open("user://" + "deck.txt", FileAccess.WRITE_READ)
	for card in deck:
		file.store_line(str(card))
	file.store_line("END")

func cardActions(card):
	#selectedCard = card.name
	selectedCard = card
	if (card.isOnTable):
		print("card is on table")
	else:
		$CardSlotsGlow.play("Glows")
		#selectedCard = 
	
	
	
	
func putPlayerCardOnTable(card, slotID: int):
	var x = 0
	var y = 0
	var rotation = 0
	
	card.scale = Vector2(cardScaleOnTable, cardScaleOnTable) 
	playerHandVision.erase(card)
	innerCircleCardNames[slotID] = card
	print(card.x)
	
	match slotID:
		0:
			
			x = get_node("PlayerCards/P1").position.x + 7
			y = get_node("PlayerCards/P1").position.y + 21
			card.rotation = (PI/8)
		1:
			x = get_node("PlayerCards/P2").position.x - 3
			y = get_node("PlayerCards/P2").position.y + 28
			card.rotation = (PI/4)
		2:
			x = get_node("PlayerCards/P3").position.x - 10
			y = get_node("PlayerCards/P3").position.y + 24
			card.rotation = (PI/3)			
		3:
			print(get_node("PlayerCards/P4").position.x)
			x = get_node("PlayerCards/P4").position.x + 30
			y = get_node("PlayerCards/P4").position.y  - 5
			card.rotation = (PI - PI/3) + PI
		4:
			x = get_node("PlayerCards/P5").position.x + 30
			y = get_node("PlayerCards/P5").position.y + 4
			card.rotation = (PI - PI/4) + PI
		5:
			x = get_node("PlayerCards/P6").position.x + 27
			y = get_node("PlayerCards/P6").position.y + 16
			card.rotation = (PI - PI/6) + PI
		6:
			x = get_node("PlayerCards/P7").position.x + 5
			y = get_node("PlayerCards/P7").position.y + 30
			card.rotation = (PI + PI/6) + PI			
		7:
			x = get_node("PlayerCards/P8").position.x - 5
			y = get_node("PlayerCards/P8").position.y + 30
			card.rotation = (PI + PI/4) + PI		
		8:
			x = get_node("PlayerCards/P9").position.x - 15
			y = get_node("PlayerCards/P9").position.y + 27
			card.rotation = (PI + PI/3) + PI
		9:
			print(get_node("PlayerCards/P9").position.x)
			x = get_node("PlayerCards/P10").position.x + 22
			y = get_node("PlayerCards/P10").position.y - 10
			card.rotation = -(PI/3)
		10:
			x = get_node("PlayerCards/P11").position.x + 25
			y = get_node("PlayerCards/P11").position.y + 2
			card.rotation = -(PI/4)
		11:
			x = get_node("PlayerCards/P12").position.x + 25
			y = get_node("PlayerCards/P12").position.y + 9
			card.rotation = -(PI/8)	
			
	card.display_card(x, y, cardScaleOnTable, card.index, cardActions)
	card.isOnTable = 1
	print(card.x)
	selectedCard = null
	
func attackCardOnTable(slotID: int):
	var chosenCard = outerCircleCardNames[slotID]
	if chosenCard:
		chosenCard.hp = chosenCard.hp - 1
		print("HP ",chosenCard.hp)
	
func useCardSlot(event, slotID: int, isInnerCircle: bool):
	if event is InputEventMouseButton:
		
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					if (isInnerCircle):
						if (selectedCard):
							print(" ! trying to put card on table ! ")
							print(slotID)
							print(selectedCard.type)
							# проверка является ли карта Юнитом и можно ли её положить на стол
							if(selectedCard.type == "Units"):
								putPlayerCardOnTable(selectedCard, slotID)
								
					pass
				MOUSE_BUTTON_RIGHT:	
					pass
						
		# if mouse button isn't pressed down
		else:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					pass
				MOUSE_BUTTON_RIGHT:	
					$CardSlotsGlow.play_backwards("Glows")
					pass
		
	


func _on_p_3_gui_input(event):
	useCardSlot(event, 2, true)
	


func _on_p_9_gui_input(event):
	useCardSlot(event, 8, true)
	


func _on_p_10_gui_input(event):
	useCardSlot(event, 9, true)


func _on_p_4_gui_input(event):
	useCardSlot(event, 3, true)


func _on_p_2_gui_input(event):
	useCardSlot(event, 1, true)


func _on_p_8_gui_input(event):
	useCardSlot(event, 7, true)


func _on_p_1_gui_input(event):
	useCardSlot(event, 0, true)


func _on_p_7_gui_input(event):
	useCardSlot(event, 6, true)


func _on_p_12_gui_input(event):
	useCardSlot(event, 11, true)


func _on_p_11_gui_input(event):
	useCardSlot(event, 10, true)


func _on_p_5_gui_input(event):
	useCardSlot(event, 4, true)


func _on_p_6_gui_input(event):
	useCardSlot(event, 5, true)
	
	
# все для ИИ

# генерация изначальной колоды (+ один ход, тк ИИ ходит первым)
func generateAICard():
	var rng = RandomNumberGenerator.new()
	for i in range(20):
		var card = rng.randi_range(0, 9)
		deckAI.append(card)
	moveAI()

# ход ИИ
func moveAI():
	if (freeCellAIDeck.size() == 0):
		return
	
	var rng = RandomNumberGenerator.new()
	# выбираем из колоды ИИ карту
	var indexCard = rng.randi_range(0, deckAI.size() - 1)
	# Если карта которая хранится в колоде по индексу IndexCard является способностью,
	# то она не кладется на стол
	if (CardsDatabase.DATA[deckAI[indexCard]][1] == "Ability"):
		var visibleCardAI = Card.instantiate()
		add_child(visibleCardAI)
		visibleCardAI.display_card(410, 440, 0.27, deckAI[indexCard], cardActions)
		visibleCardAI.playSpellAnimation()
		await get_tree().create_timer(2).timeout
		visibleCardAI.queue_free()
		return
	# выбираем слот 
	var index = rng.randi_range(0, freeCellAIDeck.size() - 1)
	var indexCell = freeCellAIDeck[index]
	# убираем ячейку из "свободных ячеек"
	freeCellAIDeck.remove_at(index)
	# добавлем карту в видимые карты ИИ по индесу слота
	var visibleCardAI = Card.instantiate()
	add_child(visibleCardAI)
	visibleCardAI.isOnTable = -1
	#Добавляем карту в массив карт которые находятся на внешнем круге
	outerCircleCardNames[indexCell] = visibleCardAI
	putCardOnTable(visibleCardAI, deckAI[indexCard], indexCell)
	# удаляем карту из доступной колоды
	deckAI.remove_at(indexCard)
	
	
	

func putCardOnTable(visibleCardAI, card, indexCell):
	
	var x = 0
	var y = 0
	var rotation = 0
	match indexCell:
		0:
			x = get_node("EnemyCards/E1").position.x + 7
			y = get_node("EnemyCards/E1").position.y + 21
			visibleCardAI.rotation = (PI/8)
		1:
			x = get_node("EnemyCards/E2").position.x - 3
			y = get_node("EnemyCards/E2").position.y + 28
			visibleCardAI.rotation = (PI/4)
		2:
			x = get_node("EnemyCards/E3").position.x - 10
			y = get_node("EnemyCards/E3").position.y + 24
			visibleCardAI.rotation = (PI/3)			
		3:
			x = get_node("EnemyCards/E4").position.x + 30
			y = get_node("EnemyCards/E4").position.y  - 5
			visibleCardAI.rotation = (PI - PI/3) + PI
		4:
			x = get_node("EnemyCards/E5").position.x + 30
			y = get_node("EnemyCards/E5").position.y + 4
			visibleCardAI.rotation = (PI - PI/4) + PI
		5:
			x = get_node("EnemyCards/E6").position.x + 27
			y = get_node("EnemyCards/E6").position.y + 16
			visibleCardAI.rotation = (PI - PI/6) + PI
		6:
			x = get_node("EnemyCards/E7").position.x + 5
			y = get_node("EnemyCards/E7").position.y + 30
			visibleCardAI.rotation = (PI + PI/6) + PI			
		7:
			x = get_node("EnemyCards/E8").position.x - 5
			y = get_node("EnemyCards/E8").position.y + 30
			visibleCardAI.rotation = (PI + PI/4) + PI		
		8:
			x = get_node("EnemyCards/E9").position.x - 15
			y = get_node("EnemyCards/E9").position.y + 27
			visibleCardAI.rotation = (PI + PI/3) + PI
		9:
			x = get_node("EnemyCards/E10").position.x + 22
			y = get_node("EnemyCards/E10").position.y - 10
			visibleCardAI.rotation = -(PI/3)
		10:
			x = get_node("EnemyCards/E11").position.x + 25
			y = get_node("EnemyCards/E11").position.y + 2
			visibleCardAI.rotation = -(PI/4)
		11:
			x = get_node("EnemyCards/E12").position.x + 25
			y = get_node("EnemyCards/E12").position.y + 9
			visibleCardAI.rotation = -(PI/8)			
			
	visibleCardAI.display_card(x, y, 0.14, card, onSelectAICard)
	cellAIDeck[indexCell] = visibleCardAI 
	
func onSelectAICard(card):
	if (selectedCard):
		if (selectedCard.isOnTable):
			print(card.hp)
			card.hp = card.hp - selectedCard.attack
			print(card.hp)
			selectedCard.hp = selectedCard.hp - card.attack
			if (card.hp <= 0 ):
				print(freeCellAIDeck)
				print(outerCircleCardNames)
				print(outerCircleCardNames.find(card))
				freeCellAIDeck.append(outerCircleCardNames.find(card))
				card.queue_free()
			
			if (selectedCard.hp <= 0 ):
				selectedCard.queue_free()
				# Удалить selectedCard из массива innerCircleCardNames
	
	selectedCard.display_card_void()
	card.display_card_void()
	selectedCard = null
			
	return
	






