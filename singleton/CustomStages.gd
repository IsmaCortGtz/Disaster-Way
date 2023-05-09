extends Node

var extra_stages_json = [
#	{
#		"id": "Easy Peasy",
#		"name": "Easy Peasy",
#		"code": "2-800-4500-700-1000-1-5-90-3-0-0"
#	}
]

func new_stage(object):
	extra_stages_json.append(object)
	save_file()


func delete_stage(id):
	if extra_stages_json.size() <= 0: return
	for x in extra_stages_json.size():
		if extra_stages_json[x].id == id:
			var _deleted = extra_stages_json.pop_at(x)
			save_file()
			break


func save_file():
	var file = File.new()
	file.open("user://custom-stages.json", File.WRITE)
	file.store_line(to_json(extra_stages_json))
	file.close()

func load_file():
	var file = File.new()
	if not file.file_exists("user://custom-stages.json"):
			 save_file()
			 return
	file.open("user://custom-stages.json", File.READ)
	extra_stages_json = parse_json(file.get_as_text())

func _ready():
	load_file()
