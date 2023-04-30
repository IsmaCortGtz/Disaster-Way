extends Area2D

var move = Vector2(1, 1)
var vel = rand_range(Level.bulletsVelRange.x, Level.bulletsVelRange.y)

func _process(delta):
	position += move.normalized() * vel * delta
	if position.x <= -200 or position.y <= -200 or position.x >= get_viewport().size.x + 200 or position.y >= get_viewport().size.y + 200:
		queue_free()


func _on_MiniBullet_body_entered(body):
	if (body.isPlayer and !body.isDestroyed and !body.isColdown):
		if body.thirdSpecial: queue_free()
		else: body.destroyed()
