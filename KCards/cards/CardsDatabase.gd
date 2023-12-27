# Unit info = [Id, Type, Cost, Name, Describe Text, Image, Attack, Health]
# Ability info = [Id, Type, Cost, Name, Describe Text, Image]
extends Node

enum {Scarecrow, Torch, Bird, Sock, Camp, Shovel, Oak, Bucket, Drum, Mirror}


const DATA = {
	Scarecrow : 
		{"id": 1, "type": "Units", "cost": 2, "name": "Огородное пугало", "description": "Карты птиц в том же секторе теряют 1 очко атаки", "imageName": "пугало.png", "attack": 1, "health": 1},
	Torch :
		{"id": 2, "type": "Ability", "cost": 3, "name": "Факел", "description": "Наносит существу или персонажу эффект горения.\n[Наносит противнику 1 ед. урона и ещё 3 ед. урона в начале вашего следующего хода]", "imageName": "огонь.png", "isTargetable": true},
	Bird:
		{"id": 3, "type": "Units", "cost": 2, "name": "Птица-певица", "description": "+1 к атаке за каждую союзную певчую птицу на поле", "imageName": "певичка.png", "attack": 2, "health": 3},
	Sock:
		{"id": 4, "type": "Ability", "cost": 3, "name": "Теплый носок", "description": "Применяется на союзное существо. Добавляет 3 ед. здоровья", "imageName": "носок.png", "isTargetable": true, "effect": "addCreatureHealth", "arguments": [3]},
	Camp:
		{"id": 5, "type": "Units", "cost": 3, "name": "Палатка", "description": "Союзные существа в секторе получают +1 ед. здоровья", "imageName": "палатка.png", "attack": 0, "health": 3},
	Shovel:
		{"id": 6, "type": "Ability", "cost": 3, "name": "Лопата", "description": "Создает в свободной ячейке выбранного сектора карту “Окопы”, обладающую 5 hp и не дающую атаковать картам противника в данном секторе игрока.", "imageName": "лопата.png"},
	Oak:
		{"id": 7, "type": "Units", "cost": 3, "name": "Хранитель леса", "description": "Повышает здоровье всех союзных карт птиц на максимум", "imageName": "дуб.png", "attack": 0, "health": 7},
	Bucket:
		{"id": 8, "type": "Ability", "cost": 1, "name": "Ведро воды", "description": "Снимает с карты эффект горения и восстанавливает 1 ед. здоровья", "imageName": "ведро.png", "isTargetable": true},
	Drum:
		{"id": 9, "type": "Units", "cost": 3, "name": "Дятел-барабанщик", "description": "В конце каждого хода наносит 1 единицу урона случайному существу противника в секторе", "imageName": "барабан.png", "attack": 0, "health": 4},
	Mirror:
		{"id": 10, "type": "Units", "cost": 2, "name": "Ручное зеркало", "description": "Снижает урон, получаемый соседними картами на 2, снижает свое hp на 1", "imageName": "зеркало.png", "attack": 0, "health": 6}
	}
	
"""
const DATA = {
	Scarecrow : 
		[1, "Units", 2, "Огородное пугало", "Карты птиц в том же секторе теряют 1 очко атаки", "пугало.png", 1, 1],
	Torch :
		[2, "Ability", 3, "Факел", "Наносит существу или персонажу эффект горения.\n[Наносит противнику 1 ед. урона и ещё 3 ед. урона в начале вашего следующего хода]", "огонь.png"],
	Bird:
		[3, "Units", 2, "Птица-певица", "+1 к атаке за каждую союзную певчую птицу на поле", "певичка.png", 2, 3],
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
"""
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
