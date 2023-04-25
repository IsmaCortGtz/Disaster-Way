extends Control

var timer = 0
var playerNode = preload("res://objects/Player/Player.tscn")
var playerColors = [Color8(242, 53, 84), Color8(69, 27, 227), Color8(227, 27, 174), Color8(227, 80, 27)]

# Called when the node enters the scene tree for the first time.
func _ready():
	print(GameInput.playersType)
	print(GameInput.usingTouch)
	get_node("Virtual joystick").visible = GameInput.usingTouch
	var playersRelativePosition = Vector2((get_viewport().size.x - 400) / 2, (get_viewport().size.y - 400) / 2)
	var playerPositions = [
		playersRelativePosition,
		Vector2(playersRelativePosition.x + 400, playersRelativePosition.y),
		Vector2(playersRelativePosition.x, playersRelativePosition.y + 400),
		Vector2(playersRelativePosition.x + 400, playersRelativePosition.y + 400),
	]
	
	for x in GameInput.playersNumber:
		var newPlayer = playerNode.instance()
		newPlayer.name = "Player" + str(x + 1)
		newPlayer.playerIndex = x + 1
		newPlayer.playerColor = playerColors[x]
		newPlayer.position = playerPositions[x]
		add_child(newPlayer)
	Music.MenuMusic.stop()
	Music.BattleMusic.play()
	Level.bulletsNode = get_node_or_null("/root/GameRoom/Bullets1")


func _process(delta):
	timer += 1 * delta
	get_node("Label").text = str(int(timer))
