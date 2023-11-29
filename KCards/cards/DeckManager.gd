extends Node

const filename = "deck.txt"
const deckMaxSize = 20
var deck = []


func _ready():
	loadFile()


func loadFile():
	var file = FileAccess.open("user://" + filename, FileAccess.READ)
	if file == null:
		return
	
	deck.clear()
	while !file.eof_reached():
		addCard(int(file.get_line()))


func saveFile():
	var file = FileAccess.open("user://" + filename, FileAccess.WRITE_READ)
	for card in deck:
		file.store_line(str(card))


func addCard(index: int):
	deck.append(index)
	if deck.size() > deckMaxSize:
		deck.remove_at(0)
	saveFile()


func removeCard(index: int):
	deck.erase(index)
	saveFile()
