extends Node

var defaultvarSettings = {
	"generalVolume": 1,
	"musicVolume": 1,
	"sfxVolume": 1,
	"fullScreen": false,
	"language": "es"
}

var settingsSavedValues = {
	"generalVolume": 1,
	"musicVolume": 1,
	"sfxVolume": 1,
	"fullScreen": false,
	"language": TranslationServer.get_locale()
}

var settingsFilePath = "user://config.cfg"
var configFile = ConfigFile.new()

# SETTING_BACK_DEFAULT
func default_settings():
	settingsSavedValues["generalVolume"] = defaultvarSettings["generalVolume"]
	settingsSavedValues["musicVolume"] = defaultvarSettings["musicVolume"]
	settingsSavedValues["sfxVolume"] = defaultvarSettings["sfxVolume"]
	settingsSavedValues["fullScreen"] = defaultvarSettings["fullScreen"]
	settingsSavedValues["language"] = defaultvarSettings["language"]
	apply_loaded()
	configFile.save(settingsFilePath)


func _ready():
	load_config()

func change_value(key, value):
	settingsSavedValues[key] = value
	save_config(key)

func save_config(key):
	configFile.set_value("settings", key, settingsSavedValues[key])
	configFile.save(settingsFilePath)


func save_all_configs():
	configFile.set_value("settings", "generalVolume", settingsSavedValues["generalVolume"])
	configFile.set_value("settings", "musicVolume", settingsSavedValues["musicVolume"])
	configFile.set_value("settings", "sfxVolume", settingsSavedValues["sfxVolume"])
	configFile.set_value("settings", "fullScreen", settingsSavedValues["fullScreen"])
	configFile.set_value("settings", "language", settingsSavedValues["language"])
	configFile.save(settingsFilePath)


func apply_loaded():
	Music.set_volume("Master", settingsSavedValues["generalVolume"])
	Music.set_volume("Music", settingsSavedValues["musicVolume"])
	Music.set_volume("SFX", settingsSavedValues["sfxVolume"])
	OS.window_fullscreen = settingsSavedValues["fullScreen"]
	TranslationServer.set_locale(settingsSavedValues["language"])


func load_config():
	var err = configFile.load(settingsFilePath)
	
	if err != OK:
		print(err)
		return
	
	if not configFile.has_section("settings"):
		configFile.save(settingsFilePath)
		return

	load_value("generalVolume")
	load_value("musicVolume")
	load_value("sfxVolume")
	load_value("fullScreen")
	load_value("language")
	apply_loaded()


func load_value(key):
	var data = configFile.get_value("settings", key, defaultvarSettings[key])
	if data != null: settingsSavedValues[key] = data
