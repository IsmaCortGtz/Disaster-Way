extends MarginContainer

signal remove_stage

export var stageCode = "1-800-4500-1500-1800-0.5-3.5-60-1"
export var stageName = "Facilito"
export var id = "t"
var isCustomLevel = false

func _ready():
	get_node("HBoxContainer/MarginContainer2").visible = isCustomLevel
	get_node("HBoxContainer/DataMargin/VBoxContainer/StageName").text = stageName
	get_node("HBoxContainer/DataMargin/VBoxContainer/StageCode").text = stageCode

func _on_Button_pressed():
	Music.clickSFX.play()
	Level.loade_stage_code(stageCode)
	if get_tree().change_scene_to(Preloader.scenes_playerSelect) != OK: print("error changing scene")


func _on_Button_focus_entered():
	Music.moveSFX.play()

func _on_DeleteButton_pressed():
	Music.clickSFX.play()
	CustomStages.delete_stage(id)
	emit_signal("remove_stage")
	queue_free()
