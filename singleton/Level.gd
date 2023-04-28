extends Node

#### Level propierties

# Example:  1-800-4500-1500-1800-0.5-3.5-90

# === Game modes Types ===
#   1 = Last standing (Play until all players dead)
#   2 = Time trial (Play for X time and try to died the minimun times as posible)
var gameModeType = 1
var playersMaxSpeed = 800
var playerAcel = 4500
var bulletsVelRange = Vector2(1500, 1800)
var bulletsControllCooldown = Vector2(0.5, 3.5)
# If gamemode is 2, the duration of the game in seconds
var gameTimeTrialDuration = 90


var validGameModesTypes = [1, 2]
var gameEnded = false
var playersPoints = [0, 0, 0, 0]
var positions = []
# playersNumber


func reset_level_data():
	gameEnded = false
	playersPoints = [0, 0, 0, 0]
	positions = []

func restart_level():
	reset_level_data()
	get_node("/root/GameRoom").timer = 0
	get_node("/root/GameRoom").playersAlive = GameInput.playersNumber
	get_node("/root/GameRoom/PausedLayer/Clasification").visible = false
	for player in GameInput.playersNumber:
		get_node("/root/GameRoom/Player" + str(player + 1)).player_reset()


func game_end():
	if (gameModeType == 1):
		pass
	
	elif (gameModeType == 2):
		pass


func loade_stage_code(code):
	var splittedCode = code.split("-", false)
	if !(validGameModesTypes.has(int(splittedCode[0]))):
		print("error in gamemode")
		return
	if (float(splittedCode[1]) <= 0):
		print("error, playersMaxSpeed need to be up to 0")
		return
	if (float(splittedCode[2]) <= 0):
		print("error, playerAcel need to be up to 0")
		return
	if (float(splittedCode[3]) <= 0):
		print("error, bulletsVelRange.x need to be up to 0")
		return
	if (float(splittedCode[4]) <= 0):
		print("error, bulletsVelRange.y need to be up to 0")
		return
	if (float(splittedCode[5]) <= 0):
		print("error, bulletsControllCooldown.x need to be up to 0")
		return
	if (float(splittedCode[6]) <= 0):
		print("error, bulletsControllCooldown.y need to be up to 0")
		return
	if (float(splittedCode[7]) <= 0):
		print("error, gameTimeTrialDuration need to be up to 0")
		return
	
	gameModeType = int(splittedCode[0])
	playersMaxSpeed = float(splittedCode[1])
	playerAcel = float(splittedCode[2])
	bulletsVelRange = Vector2(float(splittedCode[3]), float(splittedCode[4]))
	bulletsControllCooldown = Vector2(float(splittedCode[5]), float(splittedCode[6]))
	gameTimeTrialDuration = float(splittedCode[7])
