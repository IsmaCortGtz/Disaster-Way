extends Node2D

var player = Vector2(0, 0)
var move = Vector2(0, 0)
var vel


func _ready():
	vel = rand_range(Level.bulletsVelRange.x, Level.bulletsVelRange.y)
	look_at(player)
	
	var x1 = abs(player.x - position.x)
	var y1 = abs(player.y - position.y)
	
	var x2 = vel * (x1 / sqrt(pow(x1, 2) + pow(y1, 2)))
	var y2 = sqrt( pow(vel, 2) - pow(x2, 2))
	
	
	if (position.x > player.x):
		x2 *= -1
	if (position.y > player.y):
		y2 *= -1
		
	move = Vector2(x2, y2)

func _process(delta):
	position += move.normalized() * vel * delta
	if position.x <= -200 or position.y <= -200 or position.x >= get_viewport().size.x + 200 or position.y >= get_viewport().size.y + 200:
		queue_free()

func _on_Bullet_body_entered(body):
	if (body.isPlayer and !body.isDestroyed and !body.isColdown):
		#Level.bulletActivate = false
		if body.thirdSpecial:
			queue_free()
			return
		body.destroyed()
		#Level.restart_level()
