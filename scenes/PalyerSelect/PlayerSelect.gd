extends Control

var contador = 2.0
var contadorLimit = Vector2(2, 0.4)
var adding = false

var player1
var player2
var player3
var player4

var currentPlayers = 1

func _input(event):
	if ((event is InputEventKey) and (!GameInput.keyboardUsed) and (currentPlayers <= 3)):
		currentPlayers += 1
		GameInput.keyboardUsed = true
		GameInput.new_player(currentPlayers, 0, 0)
		add_player(currentPlayers)
	
	if ((event is InputEventJoypadButton) and (currentPlayers <= 3) and !GameInput.usedGamepads.has(event.device)):
		currentPlayers += 1
		GameInput.new_player(currentPlayers, 1, event.device)
		add_player(currentPlayers)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("MarginContainer/VBoxContainer/Controls/MarginContainer/HBoxContainer/MarginContainer/TextureRect").texture = GameInput.get_button_icon_image("accept")
	get_node("MarginContainer/VBoxContainer/Controls/MarginContainer2/HBoxContainer/MarginContainer/TextureRect").texture = GameInput.get_button_icon_image("back")
	player1 = get_node("MarginContainer/VBoxContainer/HBoxContainer/SelectablePlayer1")
	player2 = get_node("MarginContainer/VBoxContainer/HBoxContainer/SelectablePlayer2")
	player3 = get_node("MarginContainer/VBoxContainer/HBoxContainer2/SelectablePlayer3")
	player4 = get_node("MarginContainer/VBoxContainer/HBoxContainer2/SelectablePlayer4")
	player1.player_joined(1)

func add_player(playerN):
	if playerN == 2:
		player2.player_joined(playerN)
	if playerN == 3:
		player3.player_joined(playerN)
	if playerN == 4:
		player4.player_joined(playerN)

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
