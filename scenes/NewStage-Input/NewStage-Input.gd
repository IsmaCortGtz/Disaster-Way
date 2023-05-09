extends VBoxContainer

onready var stageCodeNode = get_node("MarginContainer/VBoxContainer/MarginContainer2/LineEdit")
onready var stageNameNode = get_node("MarginContainer/VBoxContainer/MarginContainer/LineEdit")

func _input(event):
	if event.is_action_released("ui_cancel"):
		Music.outSFX.play()
		if get_tree().change_scene_to(Preloader.scenes_More) != OK: print ("error changing scene")

func _ready():
	get_node("CanvasLayer").visible = false
	if (GameInput.playersType[0] == 2): get_node("ControlsMargin").visible = false
	get_node("MarginContainer/VBoxContainer/AddStage2/Button").grab_focus()
	get_node("ControlsMargin/Controls/MarginContainer/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("move")
	get_node("ControlsMargin/Controls/MarginContainer2/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("accept")
	get_node("ControlsMargin/Controls/MarginContainer3/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("back")


func _on_Button_pressed():
	Music.clickSFX.play()
	if Level.validate_stage_code(stageCodeNode.text):
		CustomStages.new_stage({ "id": str(OS.get_system_time_msecs())+"-"+str(int(rand_range(1, 999))), "name": stageNameNode.text, "code": stageCodeNode.text })
		if get_tree().change_scene_to(Preloader.scenes_More) != OK: print ("error changing scene")
	else:
		get_node("CanvasLayer").visible = true
		get_node("CanvasLayer/Timer").start()


func _on_Timer_timeout():
	get_node("CanvasLayer").visible = false
