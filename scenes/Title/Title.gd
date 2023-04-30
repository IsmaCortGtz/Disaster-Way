extends Control

var contador = 2.0
var contadorLimit = Vector2(2, 0.4)
var adding = false


func _input(event):
	
	if (event is InputEventKey) and (not event.is_pressed()):
		GameInput.new_player(0, 0, 0)
		if get_tree().change_scene_to(Preloader.scenes_GameMode) != OK: print("error changing scene")
	
	if (event is InputEventJoypadButton) and (not event.is_pressed()):
		GameInput.new_player(0, 1, event.device)
		if get_tree().change_scene_to(Preloader.scenes_GameMode) != OK: print("error changing scene")
	
	if (event is InputEventScreenTouch) and (not event.is_pressed()):
		GameInput.new_player(0, 2, 0)
		if get_tree().change_scene_to(Preloader.scenes_GameMode) != OK: print("error changing scene")

func _ready():
	GameInput.reset_player()

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
