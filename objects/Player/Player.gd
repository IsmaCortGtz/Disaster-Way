extends KinematicBody2D
var isPlayer = true
var firstPos = Vector2()
var isDestroyed = false
var isColdown = false
export var playerIndex = 1

var initAcel = Level.playerAcel
var velocity = Vector2.ZERO
export var playerColor = Color8(242, 53, 84)
onready var menuNode = get_node("/root/GameRoom/PausedLayer/PausedMenu")


func _input(event):
	if ((event is InputEventKey) and (not Level.gameEnded) and (GameInput.playersType[playerIndex - 1] == 0) and (not get_tree().paused) and (GameInput.keyboardUsed) and (event.scancode == KEY_ESCAPE) and (not event.is_pressed())):
		menuNode.game_paused(playerIndex - 1)
	
	if ((event is InputEventJoypadButton) and (not Level.gameEnded) and (GameInput.playersType[playerIndex - 1] == 1) and (not get_tree().paused) and (GameInput.usedGamepads.has(event.device)) and (event.button_index == 11) and (not event.is_pressed())):
		menuNode.game_paused(playerIndex - 1)

func destroyed():
	if (Level.gameEnded): return
	Music.breakSFX.play()
	isDestroyed = true
	velocity = Vector2.ZERO
	get_node("CollisionShape2D").set_deferred("disabled", true)
	get_node("DestroyParticles").restart()
	get_node("DestroyParticles").emitting = true
	get_node("Sprite").visible = false
	if (Level.gameModeType == 2):
		if Level.playersPoints[playerIndex - 1] == null: Level.playersPoints[playerIndex - 1] = 0
		Level.playersPoints[playerIndex - 1] += 1
		get_node("RespawnTimer").start()
		
	elif (Level.gameModeType == 1):
		Level.playersPoints[playerIndex - 1] = get_parent().timer
		get_parent().player_destroyed_last(playerIndex - 1)


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
	if Level.gameEnded: 
		$Particles2D.emitting = false
		return
	if !GameInput.isPlaying[playerIndex - 1]: return

	var direction = GameInput.get_axis(playerIndex) if !isDestroyed else Vector2.ZERO
	if direction == Vector2.ZERO:
		use_friction(Level.playerAcel * delta)
	else:
		$Particles2D.emitting = true
		apply_move(initAcel * delta * direction)
		
	velocity = move_and_slide(velocity)
	position.x = clamp(position.x, 0, get_viewport().size.x)
	position.y = clamp(position.y, 0, get_viewport().size.y)



func player_reset():
	position = firstPos
	get_node("CollisionShape2D").set_deferred("disabled", false)
	get_node("Sprite").visible = true
	isDestroyed = false
	get_node("Sprite").modulate.a = 1
	get_node("Particles2D").modulate.a = 1
	isColdown = false

func _on_RespawnTimer_timeout():
	position = firstPos
	get_node("CollisionShape2D").set_deferred("disabled", false)
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
