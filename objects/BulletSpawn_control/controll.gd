extends Node2D

var bala = preload("res://objects/Bullet/Bullet.tscn")
var contador = 0
var frec = 3
var time = rand_range(Level.bulletsControllCooldown.x, Level.bulletsControllCooldown.y)
var playerToShot = int(rand_range(1, GameInput.playersNumber))
var bulletsNode

func _ready():
	bulletsNode = get_node("/root/GameRoom/Bullets")

func spawnBala():
	if playerToShot > GameInput.playersNumber: playerToShot = 1
	var newBala = bala.instance()
	newBala.position = self.global_position
	var playerNode = get_node("/root/GameRoom/Player" + str(playerToShot))
	if (!playerNode.isDestroyed):
		newBala.player = playerNode.global_position
	else:
		newBala.player = get_viewport().size / 2
	bulletsNode.add_child(newBala)
	playerToShot += 1


func _process(delta):
	contador += 1 * delta
	if (contador >= time):
		time = rand_range(Level.bulletsControllCooldown.x, Level.bulletsControllCooldown.y)
		contador = 0
		spawnBala()
