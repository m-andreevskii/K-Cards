extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_buttons_dark(src: Node, target: String) -> void:
	# clearing old buttons
	$AnimationPlayer.play("dissolve2")
	await $AnimationPlayer.animation_finished
	SceneTransition.change_buttons(src, target)
	$AnimationPlayer.play_backwards("dissolve2")
	
