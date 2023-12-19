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
	generateAICard()
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
		visibleCard.display_card(200+j*70, 440, 0.27, i, onCardAdd)
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

func onCardAdd():
	$CardSlotsGlow.play("Glows")
	
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
	var rng = RandomNumberGenerator.new()
	# выбираем из колоды ИИ карту
	var indexCard = rng.randi_range(0, deckAI.size() - 1)
	# выбираем слот 
	var index = rng.randi_range(0, freeCellAIDeck.size() - 1)
	var indexCell = freeCellAIDeck[index]
	# убираем ячейку из "свободных ячеек"
	freeCellAIDeck.remove_at(index)
	# добавлем карту в видимые карты ИИ по индесу слота
	var visibleCardAI = Card.instantiate()
	add_child(visibleCardAI)
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
	
func onSelectAICard():
	return
	
