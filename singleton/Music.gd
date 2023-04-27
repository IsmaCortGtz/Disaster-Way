extends Node

onready var MenuMusic = get_node("Menu")
onready var BattleMusic = get_node("Battle")
onready var breakSFX = get_node("sfx/Break")

func _ready():
	MenuMusic.play()
