extends KinematicBody2D
var isPlayer = true
var firstPos = Vector2()
var isDestroyed = false
var isColdown = false
export var playerIndex = 1

var initAcel = Level.playerAcel
var velocity = Vector2.ZERO
export var playerColor = Color8(242, 53, 84)


func destroyed():
	isDestroyed = true
	velocity = Vector2.ZERO
	get_node("RespawnTimer").start()
	get_node("DestroyParticles").emitting = true
	get_node("DestroyParticles").restart()
	get_node("Sprite").visible = false



func _ready():
	firstPos = position
	$Sprite.modulate = playerColor
	$Particles2D.modulate = playerColor
	$DestroyParticles.modulate = playerColor


func use_friction(realAceleration):
	if (velocity.length() > realAceleration):
		velocity -= velocity.normalized() * realAceleration
	else:
		$Particles2D.emitting = false
		velocity = Vector2.ZERO

func apply_move(aceleration):
	velocity += aceleration
	velocity = velocity.limit_length(Level.playersMaxSpeed)

func _physics_process(delta):
	if !GameInput.isPlaying[playerIndex - 1]:
		return

	var direction = GameInput.get_axis(playerIndex) if !isDestroyed else Vector2.ZERO
	if direction == Vector2.ZERO:
		use_friction(Level.playerAcel * delta)
	else:
		$Particles2D.emitting = true
		apply_move(initAcel * delta * direction)
		
	velocity = move_and_slide(velocity)
	position.x = clamp(position.x, 0, get_viewport().size.x)
	position.y = clamp(position.y, 0, get_viewport().size.y)





func _on_RespawnTimer_timeout():
	position = firstPos
	get_node("Sprite").visible = true
	isDestroyed = false
	get_node("Sprite").modulate.a = 0.5
	get_node("Particles2D").modulate.a = 0.5
	isColdown = true
	get_node("Coldown").start()


func _on_Coldown_timeout():
	get_node("Sprite").modulate.a = 1
	get_node("Particles2D").modulate.a = 1
	isColdown = false
