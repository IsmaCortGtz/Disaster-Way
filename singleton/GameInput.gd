extends Node

# 0 = keyboard
# 1 = Playstation
# 2 = Xbox
var joiyMoveIcon = preload("res://assets/images/icons/buttons/joy.move.svg")
var emptySVG = preload("res://assets/images/empty.svg")
var buttons = {
	"accept": [
		preload("res://assets/images/icons/buttons/key.enter.svg"),
		preload("res://assets/images/icons/buttons/ps.x.svg"),
		preload("res://assets/images/icons/buttons/xbox.a.svg")
	],
	"move": [
		preload("res://assets/images/icons/buttons/key.move.svg"),
		joiyMoveIcon, joiyMoveIcon
	],
	"back": [
		preload("res://assets/images/icons/buttons/key.esc.svg"),
		preload("res://assets/images/icons/buttons/ps.o.svg"),
		preload("res://assets/images/icons/buttons/xbox.b.svg")
	],
	"left": [
		preload("res://assets/images/icons/buttons/key.a.svg"),
		preload("res://assets/images/icons/buttons/ps.l1.svg"),
		preload("res://assets/images/icons/buttons/xbox.lb.svg")
	],
	"right": [
		preload("res://assets/images/icons/buttons/key.d.svg"),
		preload("res://assets/images/icons/buttons/ps.r1.svg"),
		preload("res://assets/images/icons/buttons/xbox.rb.svg")
	]
}

var playerColors = [Color8(242, 53, 84), Color8(29, 96, 212), Color8(7, 127, 40), Color8(70, 70, 70)]
var gamepadDeadzone = 0.5
 
#  Input types
#    -1 = Unsigned
#     0 = Keyboard
#     1 = Gamepads (only Dualshock tested)

#  Input index
#    -1 = Unsigned
#     X = Index

var playersNumber = 0
var usedGamepads = []
var keyboardUsed = false
var playersType = [-1, -1, -1, -1]
var playersIndex = [-1, -1, -1, -1]
var isPlaying = [false, false, false, false]

var isReadySelecting = [false, false, false, false]
var numberPlayersReady = 0
var readyToStart = false


var newKeyLeftEvent
var newKeyRightEvent
var newKeyUpEvent
var newKeyDownEvent
var newKeyAcceptEvent
var newKeyCancelEvent

var newJoyLeftEvent
var newJoyRightEvent
var newJoyUpEvent
var newJoyDownEvent
var newJoyAcceptEvent
var newJoyCancelEvent

var newKeyTouchCancelEvent


func reset_player():
	playersNumber = 0
	usedGamepads = []
	keyboardUsed = false
	playersType = [-1, -1, -1, -1]
	playersIndex = [-1, -1, -1, -1]
	isPlaying = [false, false, false, false]


func reset_player_exept_first():
	playersNumber = 1
	isPlaying = [true, false, false, false]
	if (playersType[0] == 0):
		usedGamepads = []
		keyboardUsed = true
		playersType = [0, -1, -1, -1]
		playersIndex = [0, -1, -1, -1]
	else:
		var tempFirstGamepadIndex = playersIndex[0]
		usedGamepads = [tempFirstGamepadIndex]
		keyboardUsed = false
		playersType = [1, -1, -1, -1]
		playersIndex = [tempFirstGamepadIndex, -1, -1, -1]



func _ready():
	
	newKeyTouchCancelEvent = InputEventKey.new()
	newKeyTouchCancelEvent.set_scancode(KEY_0)

	newKeyLeftEvent = InputEventKey.new()
	newKeyRightEvent = InputEventKey.new()
	newKeyUpEvent = InputEventKey.new()
	newKeyDownEvent = InputEventKey.new()
	newKeyAcceptEvent = InputEventKey.new()
	newKeyCancelEvent = InputEventKey.new()
	newKeyLeftEvent.set_scancode(KEY_A)
	newKeyRightEvent.set_scancode(KEY_D)
	newKeyUpEvent.set_scancode(KEY_W)
	newKeyDownEvent.set_scancode(KEY_S)
	newKeyAcceptEvent.set_scancode(KEY_ENTER)
	newKeyCancelEvent.set_scancode(KEY_ESCAPE)
	
	newJoyLeftEvent = InputEventJoypadButton.new()
	newJoyRightEvent = InputEventJoypadButton.new()
	newJoyUpEvent = InputEventJoypadButton.new()
	newJoyDownEvent = InputEventJoypadButton.new()
	newJoyAcceptEvent = InputEventJoypadButton.new()
	newJoyCancelEvent = InputEventJoypadButton.new()
	newJoyLeftEvent.set_button_index(14)
	newJoyRightEvent.set_button_index(15)
	newJoyUpEvent.set_button_index(12)
	newJoyDownEvent.set_button_index(13)
	newJoyAcceptEvent.set_button_index(0)
	newJoyCancelEvent.set_button_index(1)

func get_new_index():
	for i in range(isPlaying.size()):
		if (isPlaying[i] == false): return i
	return -1

func new_player(index, inputType, inputIndex):
	playersType[index] = inputType
	if (inputType == 0): keyboardUsed = true
	if (inputType == 1): usedGamepads.append(inputIndex)
	playersIndex[index] = inputIndex
	isPlaying[index] = true
	playersNumber = 0
	for x in isPlaying:
		if x: playersNumber += 1





func get_axis(player):
	if (playersType[player - 1] == -1): return null
	if (playersType[player - 1] == 0):
		return Input.get_vector("player_left", "player_right", "player_up", "player_down")
	if (playersType[player - 1] == 1):
		var axis = Vector2(Input.get_joy_axis(playersIndex[player - 1], 0), Input.get_joy_axis(playersIndex[player - 1], 1))
		if abs(axis.x) < gamepadDeadzone:
			axis.x = 0
		if abs(axis.y) < gamepadDeadzone:
			axis.y = 0
		return axis.normalized()
	if (playersType[player - 1] == 2): 
		return Vector2(
			Input.get_action_strength("touch_right") - Input.get_action_strength("touch_left"),
			Input.get_action_strength("touch_down") - Input.get_action_strength("touch_up")
		).normalized()



func get_button_icon_image(action, index = 0):
	if (playersType[index] == 2):
		return emptySVG
	if (playersType[index] == 0):
		return buttons[action][0]
	var name = Input.get_joy_name(playersIndex[index])
	if (("PS" in name) or ("Playstation" in name)):
		return buttons[action][1]
	else:
		return buttons[action][2]


func remap_ui_first_player(playerIndex = 0):
	var newMappedType = playersType[playerIndex]
	var gamepadDevice = playersIndex[playerIndex]
	InputMap.action_erase_events("ui_left")
	InputMap.action_erase_events("ui_down")
	InputMap.action_erase_events("ui_up")
	InputMap.action_erase_events("ui_right")
	InputMap.action_erase_events("ui_accept")
	InputMap.action_erase_events("ui_cancel")
	
	if (newMappedType == 0):
		InputMap.action_add_event("ui_left", newKeyLeftEvent)
		InputMap.action_add_event("ui_down", newKeyDownEvent)
		InputMap.action_add_event("ui_up", newKeyUpEvent)
		InputMap.action_add_event("ui_right", newKeyRightEvent)
		InputMap.action_add_event("ui_accept", newKeyAcceptEvent)
		InputMap.action_add_event("ui_cancel", newKeyCancelEvent)

	if (newMappedType == 1):
		newJoyLeftEvent.device = gamepadDevice
		newJoyRightEvent.device = gamepadDevice
		newJoyUpEvent.device = gamepadDevice
		newJoyDownEvent.device = gamepadDevice
		newJoyAcceptEvent.device = gamepadDevice
		newJoyCancelEvent.device = gamepadDevice
		InputMap.action_add_event("ui_left", newJoyLeftEvent)
		InputMap.action_add_event("ui_down", newJoyDownEvent)
		InputMap.action_add_event("ui_up", newJoyUpEvent)
		InputMap.action_add_event("ui_right", newJoyRightEvent)
		InputMap.action_add_event("ui_accept", newJoyAcceptEvent)
		InputMap.action_add_event("ui_cancel", newJoyCancelEvent)
	
	if (newMappedType == 2):
		InputMap.action_add_event("ui_cancel", newKeyTouchCancelEvent)


func _input(event):
	if (event is InputEventKey) and (event.scancode == KEY_F11) and (not event.is_pressed()):
		OS.window_fullscreen = !OS.window_fullscreen

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		if get_tree().current_scene.name == "TitleScreen":
			get_tree().quit()
			return
		
		var ev = InputEventKey.new()
		ev.scancode = KEY_0
		get_tree().input_event(ev)
