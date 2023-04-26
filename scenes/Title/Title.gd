extends Control

var contador = 2.0
var contadorLimit = Vector2(2, 0.4)
var adding = false
var gamemodesScene = preload("res://scenes/GameMode/Gamemodes.tscn")


func _input(event):
	
	if (event is InputEventKey):
		GameInput.new_player(0, 0, 0)
		get_tree().change_scene_to(gamemodesScene)
	
	if (event is InputEventJoypadButton):
		GameInput.new_player(0, 1, event.device)
		get_tree().change_scene_to(gamemodesScene)


func _process(delta):
	if (adding and contador < contadorLimit.x):
		contador += 1 * delta
	elif (contador >= contadorLimit.x):
		adding = false
		contador -= 1 * delta
	elif (!adding and contador > contadorLimit.y):
		contador -= 1 * delta
	elif (!adding and contador <= contadorLimit.y):
		adding = true
		contador += 1 * delta
	
	get_node("PressButton").modulate.a = (contador / 2.0)
