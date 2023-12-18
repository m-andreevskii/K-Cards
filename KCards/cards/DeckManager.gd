extends Node

const filename = "deck.txt"
const deckMaxSize = 20
var deck = []


func _ready():
	loadFile()


func loadFile():
	var file = FileAccess.open("user://" + filename, FileAccess.READ)
	if file == null || file.get_length() == 0:
		return
	deck.clear()
	var str
	while !file.eof_reached():
		str = file.get_line()
		if str == "END":
			return
		else:
			addCard(int(str))


func saveFile():
	var file = FileAccess.open("user://" + filename, FileAccess.WRITE_READ)
	for card in deck:
		file.store_line(str(card))
	file.store_line("END")


func addCard(index: int):
	deck.append(index)
	if deck.size() > deckMaxSize:
		deck.remove_at(0)
	saveFile()


func removeCard(index: int):
	deck.erase(index)
	saveFile()
