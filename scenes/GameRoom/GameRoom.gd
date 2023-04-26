extends Control

var timer = 0
var playerNode = preload("res://objects/Player/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
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
		newPlayer.playerColor = GameInput.playerColors[x]
		newPlayer.position = playerPositions[x]
		add_child(newPlayer)
	Music.MenuMusic.stop()
	Music.BattleMusic.play()


func _process(delta):
	timer += 1 * delta
	get_node("Label").text = str(int(timer))
