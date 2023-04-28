extends Control

onready var resumeButton = get_node("MarginContainer/VBoxContainer/MarginContainer/Resume")

func game_paused(playerIndex = 0):
	GameInput.remap_ui_first_player(playerIndex)
	print(playerIndex)
	get_node("MarginContainer/VBoxContainer/MarginContainer3/Controls/MarginContainer/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("move", playerIndex)
	get_node("MarginContainer/VBoxContainer/MarginContainer3/Controls/MarginContainer2/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("accept", playerIndex)
	get_tree().paused = true
	self.visible = true
	resumeButton.grab_focus()
	


func _on_Resume_pressed():
	self.visible = false
	get_tree().paused = false


func _on_Exit_pressed():
	get_tree().paused = false
	Music.MenuMusic.play()
	Music.BattleMusic.stop()
	if get_tree().change_scene_to(Preloader.scenes_GameMode) != OK: print("Error changing scene")
