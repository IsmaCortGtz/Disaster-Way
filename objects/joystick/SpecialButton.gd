extends Control
var pressed = false

func shot_event():
	var ev = InputEventKey.new()
	ev.scancode = KEY_9
	get_tree().input_event(ev)


func _on_TextureButton_pressed():
	shot_event()

func _gui_input(event):
	if event is InputEventScreenTouch:
		if not pressed: 
			pressed = true
			shot_event()
			$TextureButton.modulate = Color("#90d7ff")
			$Timer.start()


func _on_Timer_timeout():
	pressed = false
	$TextureButton.modulate = Color("#ffffff")
