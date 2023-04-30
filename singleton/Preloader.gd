extends Node

var scenes_GameMode = preload("res://scenes/GameMode/Gamemodes.tscn")
var scenes_GameRoom = preload("res://scenes/GameRoom/GameRoom.tscn")
var scenes_Settings = preload("res://scenes/Settings/Settings.tscn")
var scenes_More = preload("res://scenes/More/More.tscn")
var scenes_playerSelect = preload("res://scenes/PalyerSelect/PlayerSelect.tscn")
var scenes_homeScreen = preload("res://scenes/Title/Title.tscn")
var scenes_credits = preload("res://scenes/Credits/Credits.tscn")


var character_square = preload("res://objects/Player/square.svg")
var character_hexagon = preload("res://objects/Player/hexagon.svg")
var character_pentagon = preload("res://objects/Player/pentagon.svg")
var characters_sprite = [character_square, character_hexagon, character_pentagon]
