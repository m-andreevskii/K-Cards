extends Node2D

class_name CardDisplay
#@onready 
#var CardsDatabase = preload("res://KCards/cards/CardsDatabase.gd")
#@onready
#var myCardsDatabase = CardsDatabase.new()
@onready
var Cardname = $Button/Bars/Name/CenterContainer/nameBackground/Name
@onready 
var CardImage

var index = 0
var scaler = 0
var x = 127.5
var y = 175
var Description
var default_z_index = self.z_index
var mouseLeftPressedCallback
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func display_card(x: int, y: int, scaler: float, index: int, mouseLeftPressedCallback: Callable):
	self.x = x
	self.y = y 
	self.position = Vector2(x,y)
	self.scaler = scaler 
	self.index = index
	var CardInfo = CardsDatabase.DATA[index]
	self.scale = Vector2(scaler, scaler)
	self.mouseLeftPressedCallback = mouseLeftPressedCallback
	
	var CardSize = $Button.size
	var type = CardInfo[1]
	if type == "Ability":
		$Button/Bars/BottomBar/Attack.visible = false
		$Button/Bars/BottomBar/Health.visible = false
	else: 
		$Button/Bars/BottomBar/Attack.visible = true
		$Button/Bars/BottomBar/Health.visible = true
	CardImage = str("res://KCards/images/card/card_images/", CardInfo[5])
	$Button/Background.scale = CardSize/$Button/Background.texture.get_size()
	#$Bars/Name/CenterContainer/nameBackground.scale *= CardSize/$Background.texture.get_size()
	$Button/Bars/Image.texture = load(CardImage)
	if ($Button/Bars/Image.texture != null):
		$Button/Bars/Image.scale = CardSize/($Button/Bars/Image.texture.get_size())

	if type != "Ability":
		var Attack = str(CardInfo[6])
		var Health = str(CardInfo[7])
		$Button/Bars/BottomBar/Attack/CenterContainer/attackBackground/Attack.text = Attack
		$Button/Bars/BottomBar/Health/CenterContainer/healthBackground/Health.text = Health

	var Cost = str(CardInfo[2]) 
	Description = str(CardInfo[4])
	$Button/Bars/Name/CenterContainer/nameBackground/Name.text = CardInfo[3]
	$Button/Bars/TopBar/Cost/CenterContainer/costBackground/Cost.text = Cost
	$Button/Bars/Description/CenterContainer/descrBackground/Description.text = Description
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
"""@warning_ignore("unused_parameter")
func _process(delta):
	pass
"""




# This function is responsible for any input (now it is just mouse input [mouse click input]) 
# related to cards (card scenes)
# Эта функция отвечает за любой вход связанный с картами (в данный момент нажатие и отпускание левой и правой кнопок мыши)
func _on_button_gui_input(event):
	if event is InputEventMouseButton:
		# if mouse button is pressed down (not released)
		if event.pressed:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					mouseLeftPressedCallback.call(self.name)
				MOUSE_BUTTON_RIGHT:	
					# while right mouse button is pressed, the card's scale is to twice as big as default
						self.z_index = RenderingServer.CANVAS_ITEM_Z_MAX
						$AnimationPlayer.play("Scale_Grow")
						self.scale = Vector2(scaler*1.8, scaler*1.8)
						
		# if mouse button isn't pressed down
		else:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					pass
				MOUSE_BUTTON_RIGHT:	
					# when right mouse button is released, card's scale is set to default value
						$AnimationPlayer.play_backwards("Scale_Grow")
						await $AnimationPlayer.animation_finished
						self.scale = Vector2(scaler, scaler)
						self.position = Vector2(x, y)
						self.z_index = default_z_index
	
