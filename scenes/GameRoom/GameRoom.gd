extends Control

var timer = 0
var playerNode = preload("res://objects/Player/Player.tscn")
var playersAlive = GameInput.playersNumber

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameInput.playersType[0] == 2: get_node("InputLayer").visible = true
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
	if get_tree().paused or Level.gameEnded: return
	timer += 1 * delta
	get_node("Label").text = str(int(timer))
	if (timer >= Level.gameTimeTrialDuration) and (Level.gameModeType == 2): _on_TimeTrialTimer_timeout()


func player_destroyed_last(player):
	get_node("PausedLayer/Clasification").add_player(player)
	playersAlive -= 1
	if Level.gameModeType == 1 and playersAlive <= 0:
		Level.gameEnded = true
		get_node("PausedLayer/Clasification").load_score()
		get_node("PausedLayer/Clasification").visible = true


func _on_TimeTrialTimer_timeout():
	get_node("PausedLayer/Clasification").order_timeTrial()
	Level.gameEnded = true
	get_node("PausedLayer/Clasification").load_score()
	get_node("PausedLayer/Clasification").visible = true
