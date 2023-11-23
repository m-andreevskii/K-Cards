# Unit info = [Id, Type, Cost, Name, Describe Text, Image, Attack, Health]
# Ability info = [Id, Type, Cost, Name, Describe Text, Image]
extends Node
class_name CardsDatabase

enum {Scarecrow, Torch, Bird, Sock, Camp, Shovel, Oak, Bucket, Drum, Mirror}

const DATA = {
	Scarecrow : 
		[1, "Units", 2, "Огородное пугало", "Карты птиц в том же секторе теряют 1 очко атаки", "пугало.png", 1, 1],
	Torch :
		[2, "Ability", 3, "Факел", "Наносит существу или персонажу эффект горения.\n[Наносит противнику 1 ед. урона и ещё 3 ед. урона в начале вашего следующего хода]", "огонь.png"],
	Bird:
		[3, "Units", 2, "Птица-певица", "+1 к атаке за каждую союзную певчую птицу на поле", "певичка.png", 0, 3],
	Sock:
		[4, "Ability", 3, "Теплый носок", "Применяется на союзное существо. Добавляет 3 ед. здоровья", "носок.png"],
	Camp:
		[5, "Units", 3, "Палатка", "Союзные существа в секторе получают +1 ед. здоровья", "палатка.png", 0, 3],
	Shovel:
		[6, "Ability", 3, "Лопата", "Создает в свободной ячейке выбранного сектора карту “Окопы”, обладающую 5 hp и не дающую атаковать картам противника в данном секторе игрока.", "лопата.png"],
	Oak:
		[7, "Units", 3, "Хранитель леса", "Повышает здоровье всех союзных карт птиц на максимум", "дуб.png", 0, 7],
	Bucket:
		[8, "Ability", 1, "Ведро воды", "Снимает с карты эффект горения и восстанавливает 1 ед. здоровья", "ведро.png"],
	Drum:
		[9, "Units", 3, "Дятел-барабанщик", "В конце каждого хода наносит 1 единицу урона случайному существу противника в секторе", "барабан.png", 0, 4],
	Mirror:
		[10, "Units", 2, "Ручное зеркало", "Снижает урон, получаемый соседними картами на 2, снижает свое hp на 1", "зеркало.png", 0, 6]
	}
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
