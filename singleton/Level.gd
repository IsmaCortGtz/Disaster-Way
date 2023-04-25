extends Node

var bulletActivate = true
var bulletsNode


func restart_level():
	var bulletOldName = bulletsNode.name
	get_node("/root/GameRoom/" + bulletOldName).queue_free()
	var newBullets = Node.new()
	if (bulletOldName == "Bullets1"):
		newBullets.name = "Bullets2"
	else:
		newBullets.name = "Bullets1"
	get_node("/root/GameRoom").add_child(newBullets)
	bulletsNode = get_node("/root/GameRoom/" + newBullets.name)
	bulletActivate = true
