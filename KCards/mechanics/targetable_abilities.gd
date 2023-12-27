extends Node

class_name TargetableAbilities

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


static func cast(abilityName: String, target: BattleCard, args):
	match abilityName:
		"healCreature":
			print("HEALING!")
			
		"addCreatureHealth":
			addCreatureHealth(target, args)
			
			
		
static func healCreature(card: BattleCard, args):
	if (card.max_hp > card.hp + args[0]):
		card.hp += args[0]
	else:
		card.hp = card.max_hp
	card.display_card_void()

static func addCreatureHealth(target: BattleCard, args):
	target.max_hp += args[0]
	target.hp += args[0]
	target.display_card_void()
