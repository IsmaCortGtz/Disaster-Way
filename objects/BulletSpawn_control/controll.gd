extends Node2D

var contador = 0
var frec = 3
var time = rand_range(Level.bulletsControllCooldown.x, Level.bulletsControllCooldown.y)
var playerToShot = int(rand_range(1, GameInput.playersNumber))
var bulletsNode
var demonBulletsCounter = int(rand_range(0, Level.demonBulletsFrec))
var newBala

func _ready():
	bulletsNode = get_node("/root/GameRoom/Bullets")

func spawnBala():
	if playerToShot > GameInput.playersNumber: playerToShot = 1
	
	if (demonBulletsCounter == 0) and Level.usingDemonBullets:
		newBala = Preloader.enemie_demonBala.instance()
		demonBulletsCounter = Level.demonBulletsFrec
	else:
		newBala = Preloader.enemie_normalBala.instance()
		if Level.usingDemonBullets:
			demonBulletsCounter -= 1
	
	newBala.position = self.global_position
	var playerNode = get_node("/root/GameRoom/Player" + str(playerToShot))
	if (!playerNode.isDestroyed):
		newBala.player = playerNode.global_position
	else:
		newBala.player = get_viewport().size / 2
	bulletsNode.add_child(newBala)
	playerToShot += 1


func _process(delta):
	if Level.gameEnded: return
	contador += 1 * delta
	if (contador >= time):
		time = rand_range(Level.bulletsControllCooldown.x, Level.bulletsControllCooldown.y)
		contador = 0
		spawnBala()
