extends VBoxContainer

var currentPanel = 0
onready var panels = [
	get_node("HBoxContainer/MarginContainer/GeneralCredits"),
	get_node("HBoxContainer/MarginContainer/MusicCredits"),
	get_node("HBoxContainer/MarginContainer/SFXCredits1"),
	get_node("HBoxContainer/MarginContainer/SFXCredits2")
]

func _ready():
	if (GameInput.playersType[0] == 2): get_node("ControlsMargin").visible = false
	get_node("ControlsMargin/Controls/MarginContainer2/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("back")
	get_node("HBoxContainer/MarginContainer2/CenterContainer2/Player-left/TextureRect").texture = GameInput.get_button_icon_image("left")
	get_node("HBoxContainer/MarginContainer3/CenterContainer2/Player-right/TextureRect").texture = GameInput.get_button_icon_image("right")
	

func _input(event):
	if event.is_action_released("ui_cancel"):
		Music.outSFX.play()
		if get_tree().change_scene_to(Preloader.scenes_GameMode) != OK: print ("error changing scene")
	
	if (GameInput.playersType[0] == 0) and (event is InputEventKey):
		if (event.scancode == KEY_A) and (not event.is_pressed()):
			_on_Playerleft_pressed()
			
		if (event.scancode == KEY_D) and (not event.is_pressed()):
			_on_Playerright_pressed()

	if (GameInput.playersType[0] == 1) and (event is InputEventJoypadButton) and (event.device == GameInput.playersIndex[0]):
		if (event.button_index == 4) and (not event.is_pressed()):
			_on_Playerleft_pressed()
			
		if (event.button_index == 5) and (not event.is_pressed()):
			_on_Playerright_pressed()


func _on_Playerright_pressed():
	get_node("HBoxContainer/MarginContainer3/CenterContainer2/Player-right").pressed = true
	Music.pageSFX.play()
	panels[currentPanel].visible = false
	if currentPanel >= (panels.size() - 1):
		currentPanel = 0
	else:
		currentPanel += 1
	panels[currentPanel].visible = true
	get_node("HBoxContainer/MarginContainer3/CenterContainer2/Player-right/RightTimer").start()


func _on_Playerleft_pressed():
	Music.pageSFX.play()
	get_node("HBoxContainer/MarginContainer2/CenterContainer2/Player-left").pressed = true
	panels[currentPanel].visible = false
	if currentPanel <= 0:
		currentPanel = panels.size() - 1
	else:
		currentPanel -= 1
	panels[currentPanel].visible = true
	get_node("HBoxContainer/MarginContainer2/CenterContainer2/Player-left/LeftTimer").start()


func _on_RightTimer_timeout():
	get_node("HBoxContainer/MarginContainer3/CenterContainer2/Player-right").pressed = false


func _on_LeftTimer_timeout():
	get_node("HBoxContainer/MarginContainer2/CenterContainer2/Player-left").pressed = false
