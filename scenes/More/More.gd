extends VBoxContainer


func _input(event):
	if event.is_action_released("ui_cancel"):
		if get_tree().change_scene_to(Preloader.scenes_GameMode) != OK: print ("error changing scene")

func _ready():
	get_node("MarginContainer/ScrollContainer/VBoxContainer/ExtraPage/Button").grab_focus()
	get_node("ControlsMargin/Controls/MarginContainer/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("move")
	get_node("ControlsMargin/Controls/MarginContainer2/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("accept")
	get_node("ControlsMargin/Controls/MarginContainer3/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("back")
