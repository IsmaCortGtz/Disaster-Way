extends Control

# Positions of player with index, -1 means no player

var nextPlayer = false
var playerAdded = false
var currentPoints

func load_score():
	var unit = "s"
	if Level.gameModeType == 2: unit = ""
	for index in Level.positions.size():
		currentPoints = ("%.2f" % Level.playersPoints[Level.positions[index]])
		if Level.gameModeType == 2: 
			currentPoints = str(int(Level.playersPoints[Level.positions[index]]))
			get_node("MarginContainer/VBoxContainer/VBoxContainer/MarginContainer" + str(index) + "/HBoxContainer/MarginContainer3/HBoxContainer/TextureRect").visible = true
		get_node("MarginContainer/VBoxContainer/VBoxContainer/MarginContainer" + str(index)).visible = true
		get_node("MarginContainer/VBoxContainer/VBoxContainer/MarginContainer" + str(index) + "/HBoxContainer/MarginContainer/Label").text = tr("PLAYER_WORD_SELECTING") + " " + str(Level.positions[index] + 1)
		get_node("MarginContainer/VBoxContainer/VBoxContainer/MarginContainer" + str(index) + "/HBoxContainer/MarginContainer3/HBoxContainer/MarginContainer/Label").text = currentPoints + unit
		get_node("MarginContainer/VBoxContainer/VBoxContainer/MarginContainer" + str(index) + "/HBoxContainer/MarginContainer4/TextureRect").texture = Preloader.characters_sprite[Level.playerCharacters[Level.positions[index]]]
		get_node("MarginContainer/VBoxContainer/VBoxContainer/MarginContainer" + str(index) + "/HBoxContainer/MarginContainer4/TextureRect").modulate = GameInput.playerColors[Level.positions[index]]

func _ready():
	if (GameInput.playersType[0] == 2): get_node("MarginContainer/VBoxContainer/MarginContainer").visible = false
	get_node("MarginContainer/VBoxContainer/MarginContainer/Controls/MarginContainer/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("move")
	get_node("MarginContainer/VBoxContainer/MarginContainer/Controls/MarginContainer2/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("accept")

func order_timeTrial():
	if Level.positions.size() == 0: Level.positions = [0]
	for player in range(1, GameInput.playersNumber):
		playerAdded = false
		for check in Level.positions.size():
			if (Level.playersPoints[player] < Level.playersPoints[check]):
				Level.positions.insert(check, player)
				playerAdded = true
				break
		if not playerAdded:
			Level.positions.append(player)
	print(Level.positions)
	print(Level.playersPoints)

func add_player(playerIndex):
	playerAdded = false
	if Level.positions.size() == 0:
		Level.positions.append(playerIndex)
		return
	
	if Level.gameModeType == 1:
		for check in Level.positions.size():
			if (Level.playersPoints[playerIndex] > Level.playersPoints[Level.positions[check]]):
				Level.positions.insert(check, playerIndex)
				playerAdded = true
				break
		if (not playerAdded):
			Level.positions.append(playerIndex)


func _on_Clasification_visibility_changed():
	if visible: get_node("MarginContainer/VBoxContainer/Buttons/MarginContainer/PlayAgain").grab_focus()


func _on_Menu_pressed():
	Music.clickSFX.play()
	Level.reset_level_data()
	Music.MenuMusic.play()
	Music.BattleMusic.stop()
	if get_tree().change_scene_to(Preloader.scenes_GameMode) != OK: print("error changing scene")


func _on_PlayAgain_pressed():
	Music.clickSFX.play()
	Level.restart_level()


func _on_button_focus_entered():
	Music.moveSFX.play()
