extends CanvasLayer


func change_scene(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")
	
	
func change_buttons(src: Node, target: String) -> void:
	# clearing old buttons
	for x in src.get_children():
		x.queue_free()

	# adding new buttons to Scene tree
	var newButtons = load(target)
	add_child(newButtons.instantiate())
	
