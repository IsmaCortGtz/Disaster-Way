extends Node2D

var bala = preload("res://objects/Bullet/Bullet.tscn")
var contador = 0
var frec = 3
var time = (randf() * frec) + 0.5
var playerToShot = int(rand_range(1, GameInput.playersNumber))

func _ready():
	var aspect_ratio = get_viewport().size.x / get_viewport().size.y
	if aspect_ratio > 1.77777777778:
		print("Not 16:9")


func spawnBala():
	if playerToShot > GameInput.playersNumber: playerToShot = 1
	var newBala = bala.instance()
	newBala.position = self.global_position
	var playerNode = get_node("/root/GameRoom/Player" + str(playerToShot))
	if (!playerNode.isDestroyed):
		newBala.player = playerNode.global_position
	else:
		newBala.player = get_viewport().size / 2
	Level.bulletsNode.add_child(newBala)
	playerToShot += 1


func _process(delta):
	contador += 1 * delta
	if (contador >= time) and Level.bulletActivate:
		time = (randf() * frec) + 0.5
		contador = 0
		spawnBala()
