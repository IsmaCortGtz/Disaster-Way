extends Control

var contador = 2.0
var contadorLimit = Vector2(2, 0.4)
var adding = false


var player1
var player2
var player3
var player4

func _input(event):
	var newIndex = GameInput.get_new_index()
	if ((event is InputEventKey) and (!GameInput.keyboardUsed) and (newIndex != -1) and (event.scancode == KEY_ENTER) and (not event.is_pressed())):
		GameInput.keyboardUsed = true
		GameInput.new_player(newIndex, 0, 0)
		add_player(newIndex)
	
	if ((event is InputEventJoypadButton) and (newIndex != -1) and !GameInput.usedGamepads.has(event.device) and (event.button_index == 11) and (not event.is_pressed())):
		GameInput.new_player(newIndex, 1, event.device)
		add_player(newIndex)
	
	if event.is_action_released("ui_cancel"):
		if (not GameInput.isReadySelecting[0]):
			Music.outSFX.play()
			if get_tree().change_scene_to(Preloader.scenes_GameMode) != OK: print("error changing scene")
		else:
			player1.player_not_ready()

# Called when the node enters the scene tree for the first time.
func _ready():
	if (GameInput.playersType[0] == 2): get_node("MarginContainer/VBoxContainer/Controls").visible = false
	GameInput.isReadySelecting = [false, false, false, false]
	GameInput.numberPlayersReady = 0
	get_node("MarginContainer/VBoxContainer/Controls/MarginContainer/HBoxContainer/MarginContainer/TextureRect").texture = GameInput.get_button_icon_image("accept")
	get_node("MarginContainer/VBoxContainer/Controls/MarginContainer2/HBoxContainer/MarginContainer/TextureRect").texture = GameInput.get_button_icon_image("back")
	player1 = get_node("MarginContainer/VBoxContainer/HBoxContainer/SelectablePlayer1")
	player2 = get_node("MarginContainer/VBoxContainer/HBoxContainer/SelectablePlayer2")
	player3 = get_node("MarginContainer/VBoxContainer/HBoxContainer2/SelectablePlayer3")
	player4 = get_node("MarginContainer/VBoxContainer/HBoxContainer2/SelectablePlayer4")
	player1.player_joined(0)
	
	for i in range(GameInput.isPlaying.size()):
		if GameInput.isPlaying[i]:
			add_player(i)

func add_player(playerN):
	Music.clickSFX.play()
	if playerN == 1:
		player2.player_joined(playerN)
	if playerN == 2:
		player3.player_joined(playerN)
	if playerN == 3:
		player4.player_joined(playerN)
	_on_player_ready_signal()

func _process(delta):
	if (adding and contador < contadorLimit.x):
		contador += 1 * delta
	elif (contador >= contadorLimit.x):
		adding = false
		contador -= 1 * delta
	elif (!adding and contador > contadorLimit.y):
		contador -= 1 * delta
	elif (!adding and contador <= contadorLimit.y):
		adding = true
		contador += 1 * delta
	
	player1.label_alpha(contador / 2.0)
	player2.label_alpha(contador / 2.0)
	player3.label_alpha(contador / 2.0)
	player4.label_alpha(contador / 2.0)


func _on_player_ready_signal():
	if (GameInput.numberPlayersReady == GameInput.playersNumber):
		GameInput.readyToStart = true
		get_node("MarginContainer/VBoxContainer/Controls/MarginContainer/HBoxContainer/Label").text = tr("START_BUTTON_WORD")
	else:
		GameInput.readyToStart = false
		get_node("MarginContainer/VBoxContainer/Controls/MarginContainer/HBoxContainer/Label").text = tr("PLAYER_READY_LABEL")
