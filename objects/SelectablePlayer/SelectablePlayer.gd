extends MarginContainer

var joinLabel: Label
var joined = false

func _ready():
	joinLabel = get_node("MarginContainer/Label")

func label_alpha(alpha: float):
	joinLabel.modulate.a = alpha

func player_joined(index):
	get_node("MarginContainer").visible = false
	get_node("HBoxContainer/VBoxContainer/Player Num").text = "Jugador " + str(index)
	get_node("HBoxContainer/VBoxContainer/MarginContainer/Player-image").modulate = GameInput.playerColors[index - 1]
	get_node("HBoxContainer/CenterContainer/Player-left").self_modulate = GameInput.playerColors[index - 1]
	get_node("HBoxContainer/CenterContainer2/Player-right").self_modulate = GameInput.playerColors[index - 1]
	get_node("HBoxContainer").visible = true
