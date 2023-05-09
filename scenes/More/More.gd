extends VBoxContainer

var defaultLevelsCodes = [
	{
		"name": "Easy Peasy",
		"code": "2-800-4500-700-1000-1-5-90-3-0-0"
	},
	{
		"name": "Middle",
		"code": "2-800-3000-1000-1400-0.8-3.5-60-2-1-10"
	},
	{
		"name": "Demon",
		"code": "1-1000-5000-1800-2000-0.5-1.5-10-1-1-3"
	},
	{
		"name": "Trial Demon",
		"code": "2-1000-5000-1800-2000-0.5-1.5-40-1-1-3"
	},
	{
		"name": "Slow Down",
		"code": "2-800-5000-1800-2000-1.5-2.5-30-1-1-3"
	},
	{
		"name": "Full Demon",
		"code": "1-1000-5000-1800-2000-0.5-1.5-10-0-1-0"
	},
	{
		"name": "Full Demon Trial",
		"code": "2-1000-5000-1800-2000-0.5-1.5-60-0-1-0"
	},
	{
		"name": "Max Speed Hard",
		"code": "2-1300-5500-1800-2000-2.5-3.5-60-5-1-0"
	}
]

func _input(event):
	if event.is_action_released("ui_cancel"):
		Music.outSFX.play()
		if get_tree().change_scene_to(Preloader.scenes_GameMode) != OK: print ("error changing scene")

func _ready():
	
	for levelData in defaultLevelsCodes:
		spawnNewLevel(levelData.name, levelData.code)
	
	if CustomStages.extra_stages_json.size() > 0:
		for levelData in CustomStages.extra_stages_json:
			spawnNewLevel(levelData.name, levelData.code, true, levelData.id)
	
	if (GameInput.playersType[0] == 2): get_node("ControlsMargin").visible = false
	get_node("MarginContainer/ScrollContainer/VBoxContainer/ExtraPage/Button").grab_focus()
	get_node("ControlsMargin/Controls/MarginContainer/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("move")
	get_node("ControlsMargin/Controls/MarginContainer2/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("accept")
	get_node("ControlsMargin/Controls/MarginContainer3/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("back")


func spawnNewLevel(levelName, levelCode, isCustom = false, id = null):
	var newLevel = Preloader.level_stage.instance()
	newLevel.name = "ExtraStage_" + levelName
	newLevel.stageCode = levelCode
	newLevel.stageName = levelName
	if isCustom:
		newLevel.isCustomLevel = true
		newLevel.id = id
	get_node("MarginContainer/ScrollContainer/VBoxContainer/StageContainer").add_child(newLevel)
	var _connected_value = get_node("MarginContainer/ScrollContainer/VBoxContainer/StageContainer/ExtraStage_" + levelName).connect("remove_stage", self, "_on_custom_deleted")

func _on_Button_pressed():
	Music.clickSFX.play()
	if OS.shell_open("https://github.com/IsmaCortGtz/Disaster-Way") != OK: print("Error opening URL")


func _on_Button_focus_entered():
	Music.moveSFX.play()


func _on_custom_deleted():
	get_node("MarginContainer/ScrollContainer/VBoxContainer/ExtraPage/Button").grab_focus()

func _on_AddButton_pressed():
	Music.clickSFX.play()
	if get_tree().change_scene_to(Preloader.scenes_newStageInput) != OK: print ("error changing scene")
