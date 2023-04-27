extends Control

var playerSelectScene = preload("res://scenes/GameRoom/GameRoom.tscn")
var playerSelect = preload("res://scenes/PalyerSelect/PlayerSelect.tscn")
var homeScreen = load("res://scenes/Title/Title.tscn")
var firstUsed = true

func _input(event):
	if (((event is InputEventJoypadButton) or (event is InputEventJoypadMotion) or (event is InputEventKey) or (event is InputEventScreenTouch)) and firstUsed):
		get_node("GlobalMargin/VBoxContainer/MainHBox/MarginButton/LastStand").grab_focus()
		firstUsed = false

func _ready():
	get_node("GlobalMargin/VBoxContainer/MarginContainer/Controls/MarginContainer2/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("accept")
	get_node("GlobalMargin/VBoxContainer/MarginContainer/Controls/MarginContainer/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("move")

func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	get_tree().change_scene_to(homeScreen)


func _on_TimeTrial_pressed():
	Level.loade_stage_code("2-800-4500-1500-1800-0.5-3.5-90")
	get_tree().change_scene_to(playerSelect)


func _on_LastStand_pressed():
	Level.loade_stage_code("1-800-4500-1500-1800-0.5-3.5-90")
	get_tree().change_scene_to(playerSelectScene)
