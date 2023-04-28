extends Control


func _input(event):

	if event.is_action_released("ui_cancel"):
		if get_tree().change_scene_to(Preloader.scenes_homeScreen)  != OK: print("error changing scene")

func _ready():
	GameInput.remap_ui_first_player()
	get_node("GlobalMargin/VBoxContainer/MainHBox/MarginButton/LastStand").grab_focus()
	get_node("GlobalMargin/VBoxContainer/MarginContainer/Controls/MarginContainer/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("move")
	get_node("GlobalMargin/VBoxContainer/MarginContainer/Controls/MarginContainer2/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("accept")
	get_node("GlobalMargin/VBoxContainer/MarginContainer/Controls/MarginContainer3/HBoxContainer/TextureRect3").texture = GameInput.get_button_icon_image("back")

func _on_Exit_pressed():
	get_tree().quit()


func _on_Back_pressed():
	if ("es" in TranslationServer.get_locale()):
		TranslationServer.set_locale("en")
	else: 
		TranslationServer.set_locale("es")


func _on_TimeTrial_pressed():
	Level.loade_stage_code("2-800-4500-1500-1800-0.5-3.5-60")
	if get_tree().change_scene_to(Preloader.scenes_playerSelect) != OK: print("error changing scene")


func _on_LastStand_pressed():
	Level.loade_stage_code("1-800-4500-1500-1800-0.5-3.5-60")
	if get_tree().change_scene_to(Preloader.scenes_playerSelect) != OK: print("error changing scene")
