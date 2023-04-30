extends Node

onready var MenuMusic = get_node("Menu")
onready var BattleMusic = get_node("Battle")
onready var breakSFX = get_node("sfx/Break")
onready var pageSFX = get_node("sfx/Page")
onready var moveSFX = get_node("sfx/Move")
onready var clickSFX = get_node("sfx/Click")
onready var outSFX = get_node("sfx/Out")
onready var splitSFX = get_node("sfx/Split")

func _ready():
	MenuMusic.play()


func log10(x):
	return log(x) / log(10)

func set_volume(bus, newVolume):
	var busIndex = AudioServer.get_bus_index(bus)
	if (busIndex == -1): 
		print("Error getting bus")
		return

	AudioServer.set_bus_volume_db(busIndex, linear2db(newVolume))

func get_volume(bus):
	
	var busIndex = AudioServer.get_bus_index(bus)
	if (busIndex == -1): 
		print("Error getting bus")
		return
	var busDB = AudioServer.get_bus_volume_db(busIndex)
	return db2linear(busDB)
