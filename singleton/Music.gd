extends Node

onready var MenuMusic = get_node("Menu")
onready var BattleMusic = get_node("Battle")
onready var breakSFX = get_node("sfx/Break")

func _ready():
	MenuMusic.play()


func set_volume(bus, newVolume):
	var busIndex = AudioServer.get_bus_index(bus)
	if (busIndex == -1): 
		print("Error getting bus")
		return

	AudioServer.set_bus_volume_db(busIndex, newVolume)

func get_volume(bus):
	var busIndex = AudioServer.get_bus_index(bus)
	if (busIndex == -1): 
		print("Error getting bus")
		return
	return AudioServer.get_bus_volume_db(busIndex)
