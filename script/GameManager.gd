extends Node

const save_path = "user://fading_ember.save"
@export var score:int = 0
@export var HighScore:int = 0
@export var background_music_value: float = 100.0
@export var sound_effects_value: float = 100 
@export var muted: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()
	score=0
	
func save_data():
	var data_dict = {
		"score": score,
		"HighScore": HighScore,
		"background_music_value": background_music_value,
		"sound_effects_value": sound_effects_value,
		"muted": muted
	}
	
	var json_string = JSON.stringify(data_dict)
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()
	
func load_data():
	if not FileAccess.file_exists(save_path):
		return
	var file = FileAccess.open(save_path, FileAccess.READ)
	
	if not file:
		return
	
	var json_string = file.get_as_text()
	file.close()
	var json = JSON.new()
	var check_error = json.parse(json_string)
	if check_error==OK:
		var data_dict=json.data
		score = data_dict.get("score", score)
		HighScore = data_dict.get("HighScore", HighScore)
		background_music_value = data_dict.get("background_music_value", background_music_value)
		sound_effects_value = data_dict.get("sound_effects_value", sound_effects_value)
		muted = data_dict.get("muted", muted)
		
func check_and_load_data():
	save_data()
