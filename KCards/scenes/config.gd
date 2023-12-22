extends Node

const filePath = "user://configFile.cfg"

var configFile = ConfigFile.new()

# Default settings (the array might be changed at runtime):
var _settings = {
	"audio": {
		"music_volume": 0.5
	},
	"graphics": {
		"is_fullscreen": true
	}
}

	
# Called when the node enters the scene tree for the first time.
func _ready():
	loadSettings()
	pass # Replace with function body.



func saveSettings():
	for section in _settings.keys():
		for key in _settings[section]:
			configFile.set_value(section, key, (_settings[section])[key])
			configFile.save(filePath)
			pass
	
	
func loadSettings():
	var error = configFile.load(filePath)
	if error != OK:
		print("Falied loading config file. Error code: ", error)
		return
		
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = configFile.get_value(section, key, null)
	
	
func setConfigValue(section: String, key: String, value):
	_settings[section][key] = value
	saveSettings()
	
	
func getConfigValue(section: String, key: String):
	return _settings[section][key]
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
