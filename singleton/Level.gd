extends Node

const miniBulletsDirections = [
	Vector2(1, 1),
	Vector2(-1, 1),
	Vector2(1, -1),
	Vector2(-1, -1)
]
#### Level propierties

# Example:  1-800-4500-1500-1800-0.5-3.5-90-1

# 2-800-4500-700-1000-1-5-90-3-0-0
# 2-800-3000-1000-1400-0.8-3.5-60-2-1-10
# 1-1000-5000-1800-2000-0.5-1.5-10-1-1-3

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
var specialTimesUses = 1
var usingDemonBullets = true # 1 or 0
var demonBulletsFrec = 3


# Characters ID
#  0 = Square
#  1 = Hexagon
#  2 = Pentagon
var playerCharacters = [0, 0, 0, 0]
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
	if (int(splittedCode[8]) <= 0):
		print("error, specialTimesUses need to be up to 0")
		return
	if (int(splittedCode[9]) != 0) and (int(splittedCode[9]) != 1):
		print("error, usingDemonBullets need to be 0 ro 1")
		return
	if (int(splittedCode[10]) < 0):
		print("error, demonBulletsFrec need to be at least 0 or more")
		return
	
	gameModeType = int(splittedCode[0])
	playersMaxSpeed = float(splittedCode[1])
	playerAcel = float(splittedCode[2])
	bulletsVelRange = Vector2(float(splittedCode[3]), float(splittedCode[4]))
	bulletsControllCooldown = Vector2(float(splittedCode[5]), float(splittedCode[6]))
	gameTimeTrialDuration = float(splittedCode[7])
	specialTimesUses = int(splittedCode[8])
	usingDemonBullets = bool(int(splittedCode[9]))
	demonBulletsFrec = int(splittedCode[10])
