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
#var deckAIVision = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1] # может потом на это заменить

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
			#get_node("EnemyCards/EE1").set_normal_texture("i")
			x = get_node("EnemyCards/E1").position.x + 7
			y = get_node("EnemyCards/E1").position.y + 21
			#visibleCardAI.look_at(Vector2(-18,18))
			print(x, y)
		1:
			x = get_node("EnemyCards/E2").position.x - 5
			y = get_node("EnemyCards/E2").position.y + 21
			#visibleCardAI.look_at(Vector2(23,142))
			print(x, y)
		2:
			x = get_node("EnemyCards/E3").position.x - 10
			y = get_node("EnemyCards/E3").position.y + 24
			#visibleCardAI.look_at(Vector2(23,142))
			print(x, y)
		3:
			x = get_node("EnemyCards/E4").position.x + 20
			y = get_node("EnemyCards/E4").position.y - 7
			print(x, y)
		4:
			x = get_node("EnemyCards/E5").position.x + 25
			y = get_node("EnemyCards/E5").position.y
			print(x, y)
		5:
			x = get_node("EnemyCards/E6").position.x + 20
			y = get_node("EnemyCards/E6").position.y + 10
			print(x, y)
		6:
			x = get_node("EnemyCards/E7").position.x + 5
			y = get_node("EnemyCards/E7").position.y + 20
			print(x, y)
		7:
			x = get_node("EnemyCards/E8").position.x
			y = get_node("EnemyCards/E8").position.y + 27
			print(x, y)
		8:
			x = get_node("EnemyCards/E9").position.x - 10
			y = get_node("EnemyCards/E9").position.y + 20
			print(x, y)
		9:
			x = get_node("EnemyCards/E10").position.x + 20
			y = get_node("EnemyCards/E10").position.y
			print(x, y)
		10:
			x = get_node("EnemyCards/E11").position.x + 25
			y = get_node("EnemyCards/E11").position.y + 5
			print(x, y)
		11:
			x = get_node("EnemyCards/E12").position.x + 15
			y = get_node("EnemyCards/E12").position.y + 10
			print(x, y)
			
	visibleCardAI.display_card(x, y, 0.14, card, onSelectAICard)
	#visibleCardAI.rotation = rotation
	
	cellAIDeck[indexCell] = visibleCardAI 
	
func onSelectAICard():
	return
	
