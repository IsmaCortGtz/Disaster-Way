extends MarginContainer

var joinLabel: Label
var joined = false
var playerIndex = 0
var mouseInZone = false

signal player_ready_signal

onready var clickSound = get_node("ClickSound")
var leftButton: TextureButton
var rightButton: TextureButton

func _input(event):
	if not joined:
		return
	
	if (GameInput.playersType[playerIndex] == 2) and (event is InputEventKey):
		if (event.scancode == KEY_0) and (not event.is_pressed() and (playerIndex != 0)):
			player_not_ready()

	if (GameInput.playersType[playerIndex] == 0) and (event is InputEventKey):
		if (event.scancode == KEY_A) and (not event.is_pressed() and (not GameInput.isReadySelecting[playerIndex])):
			leftButton.pressed = true
			leftButton.emit_signal("pressed")
			
		if (event.scancode == KEY_D) and (not event.is_pressed() and (not GameInput.isReadySelecting[playerIndex])):
			rightButton.pressed = true
			rightButton.emit_signal("pressed")
			
		if (event.scancode == KEY_ENTER) and (not event.is_pressed()):
			player_ready()
		if (event.scancode == KEY_ESCAPE) and (not event.is_pressed() and (playerIndex != 0)):
			player_not_ready()
	if (GameInput.playersType[playerIndex] == 1) and (event is InputEventJoypadButton) and (event.device == GameInput.playersIndex[playerIndex]):
		if (event.button_index == 4) and (not event.is_pressed() and (not GameInput.isReadySelecting[playerIndex])):
			leftButton.pressed = true
			leftButton.emit_signal("pressed")
			
		if (event.button_index == 5) and (not event.is_pressed() and (not GameInput.isReadySelecting[playerIndex])):
			rightButton.pressed = true
			rightButton.emit_signal("pressed")
		if (event.button_index == 0) and (not event.is_pressed()):
			player_ready()
		if (event.button_index == 1) and (not event.is_pressed() and (playerIndex != 0)):
			player_not_ready()




func change_character_left():
	if Level.playerCharacters[playerIndex] <= 0:
		Level.playerCharacters[playerIndex] = Preloader.characters_sprite.size() - 1
	else:
		Level.playerCharacters[playerIndex] -= 1
	update_character_sprite()

func change_character_right():
	if Level.playerCharacters[playerIndex] >= (Preloader.characters_sprite.size() - 1):
		Level.playerCharacters[playerIndex] = 0
	else:
		Level.playerCharacters[playerIndex] += 1
	update_character_sprite()

func update_character_sprite():
	get_node("HBoxContainer/VBoxContainer/MarginContainer/Player-image").set_normal_texture(Preloader.characters_sprite[Level.playerCharacters[playerIndex]])

func _ready():
	update_character_sprite()
	joinLabel = get_node("MarginContainer/Label")
	leftButton = get_node("HBoxContainer/CenterContainer/Player-left")
	rightButton = get_node("HBoxContainer/CenterContainer2/Player-right")


func player_ready():
	if (not GameInput.isReadySelecting[playerIndex]):
		Music.clickSFX.play()
		GameInput.isReadySelecting[playerIndex] = true
		GameInput.numberPlayersReady += 1
		get_node("ReadyContainer").visible = true
		emit_signal("player_ready_signal")
	elif playerIndex == 0 and GameInput.readyToStart:
		Music.clickSFX.play()
		if get_tree().change_scene_to(Preloader.scenes_GameRoom) != OK: print("error changing scene")


func player_not_ready():
	if (GameInput.isReadySelecting[playerIndex]):
		Music.outSFX.play()
		GameInput.isReadySelecting[playerIndex] = false
		GameInput.numberPlayersReady -= 1
		get_node("ReadyContainer").visible = false
		emit_signal("player_ready_signal")


func label_alpha(alpha: float):
	joinLabel.modulate.a = alpha


func player_joined(index):
	playerIndex = index
	update_character_sprite()
	get_node("MarginContainer").visible = false
	
	get_node("HBoxContainer/CenterContainer/Player-left/TextureRect").texture = GameInput.get_button_icon_image("left", index)
	get_node("HBoxContainer/CenterContainer2/Player-right/TextureRect").texture = GameInput.get_button_icon_image("right", index)
	
	get_node("HBoxContainer/VBoxContainer/Player Num").text = tr("PLAYER_WORD_SELECTING") + " " + str(index + 1)
	get_node("HBoxContainer/VBoxContainer/MarginContainer/Player-image").modulate = GameInput.playerColors[index]
	get_node("HBoxContainer/CenterContainer/Player-left").self_modulate = GameInput.playerColors[index]
	get_node("HBoxContainer/CenterContainer2/Player-right").self_modulate = GameInput.playerColors[index]
	get_node("HBoxContainer").visible = true
	joined = true


func _on_Playerleft_pressed():
	clickSound.play()
	change_character_left()
	get_node("HBoxContainer/CenterContainer/Player-left/TimerLeft").start()


func _on_Playerright_pressed():
	clickSound.play()
	change_character_right()
	get_node("HBoxContainer/CenterContainer2/Player-right/TimerRight").start()


func _on_TimerLeft_timeout():
	leftButton.pressed = false


func _on_TimerRight_timeout():
	rightButton.pressed = false


func _on_VBoxContainer_mouse_entered():
	mouseInZone = true


func _on_VBoxContainer_mouse_exited():
	mouseInZone = false


func _on_Playerimage_pressed():
	player_ready()
