extends Control

var playerSelectScene = preload("res://scenes/GameRoom/GameRoom.tscn")
var playerSelect = preload("res://scenes/PalyerSelect/PlayerSelect.tscn")
var homeScreen = load("res://scenes/Title/Title.tscn")
var firstUsed = true

func _input(event):
	if (((event is InputEventJoypadButton) or (event is InputEventJoypadMotion)) and (GameInput.playersType[0] == 1) and firstUsed):
		get_node("GlobalMargin/VBoxContainer/MainHBox/MarginButton/Contrareloj").grab_focus()
		firstUsed = false



func _on_Button_pressed():
	get_tree().change_scene_to(playerSelectScene)


func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	get_tree().change_scene_to(homeScreen)


func _on_TimeTrial_pressed():
	get_tree().change_scene_to(playerSelect)
