extends Node

onready var MenuMusic = get_node("Menu")
onready var BattleMusic = get_node("Battle")

func _ready():
	MenuMusic.play()
