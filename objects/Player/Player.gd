extends KinematicBody2D
var isPlayer = true
var firstPos = Vector2()
var isDestroyed = false
var isColdown = false
var playerIndex = 1

var specialAvailable = Level.specialTimesUses
var specialActivated = false
var specialMulti =  1
var thirdSpecial = false

var initAcel = Level.playerAcel
var velocity = Vector2.ZERO
var playerColor = Color8(242, 53, 84)
onready var menuNode = get_node("/root/GameRoom/PausedLayer/PausedMenu")


func _input(event):
	
	if ((event is InputEventKey) and (not Level.gameEnded) and (GameInput.playersType[playerIndex - 1] == 2) and (event.scancode == KEY_0) and (not event.is_pressed())):
		menuNode.game_paused(playerIndex - 1)
	
	if ((event is InputEventKey) and (not Level.gameEnded) and (GameInput.playersType[playerIndex - 1] == 0) and (GameInput.keyboardUsed) and (event.scancode == KEY_ESCAPE) and (not event.is_pressed())):
		menuNode.game_paused(playerIndex - 1)
	
	if ((event is InputEventJoypadButton) and (not Level.gameEnded) and (GameInput.playersType[playerIndex - 1] == 1) and (GameInput.usedGamepads.has(event.device)) and (event.button_index == 11) and (not event.is_pressed())):
		menuNode.game_paused(playerIndex - 1)
	
	if ((event is InputEventKey) and (not Level.gameEnded) and (GameInput.playersType[playerIndex - 1] == 2) and (event.scancode == KEY_9) and (not event.is_pressed())):
		start_special()
	
	if ((event is InputEventKey) and (not Level.gameEnded) and (GameInput.playersType[playerIndex - 1] == 0) and (GameInput.keyboardUsed) and (event.scancode == KEY_SPACE) and (not event.is_pressed())):
		start_special()
	
	if ((event is InputEventJoypadButton) and (not Level.gameEnded) and (GameInput.playersType[playerIndex - 1] == 1) and (GameInput.usedGamepads.has(event.device)) and (event.button_index == 2) and (not event.is_pressed())):
		start_special()

func destroyed():
	if (Level.gameEnded): return
	_on_SpecialTimer_timeout()
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
	$Sprite.texture = Preloader.characters_sprite[Level.playerCharacters[playerIndex - 1]]
	firstPos = position
	$Sprite.modulate = playerColor
	$Particles2D.modulate = playerColor
	$DestroyParticles.modulate = playerColor


func start_special():
	if specialActivated: return
	if (specialAvailable <= 0) or isColdown or isDestroyed: return
	if Level.playerCharacters[playerIndex - 1] == 0: get_node("CollisionShape2D").set_deferred("disabled", true)
	if Level.playerCharacters[playerIndex - 1] == 1: specialMulti = 1.6
	if Level.playerCharacters[playerIndex - 1] == 2: thirdSpecial = true
	specialAvailable -= 1
	$Special.visible = true
	specialActivated = true
	$SpecialTimer.start()


func _on_SpecialTimer_timeout():
	specialMulti = 1
	specialActivated = false
	thirdSpecial = false
	$Special.visible = false
	if Level.playerCharacters[playerIndex - 1] == 0: get_node("CollisionShape2D").set_deferred("disabled", false)

func use_friction(realAceleration):
	if (velocity.length() > realAceleration):
		velocity -= velocity.normalized() * realAceleration
	else:
		$Particles2D.emitting = false
		velocity = Vector2.ZERO

func apply_move(aceleration):
	velocity += aceleration * specialMulti
	velocity = velocity.limit_length(Level.playersMaxSpeed * specialMulti)



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
	specialAvailable = Level.specialTimesUses
	_on_SpecialTimer_timeout()

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
