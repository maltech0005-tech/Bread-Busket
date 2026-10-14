extends Node2D
@export var bread: PackedScene
@export var hail: PackedScene
@onready var spawn_timer: Timer = $spawn_timer
@onready var hail_timer: Timer = $hail_timer
@onready var master_v_slider: HSlider = $Menu_Container/HBoxContainer/VBoxContainer2/HBoxContainer/master_v_slider
@onready var master_v_amnt: Label = $Menu_Container/HBoxContainer/VBoxContainer2/HBoxContainer/master_v_amnt
@onready var music_v_slider: HSlider = $Menu_Container/HBoxContainer/VBoxContainer2/HBoxContainer2/music_v_slider
@onready var music_v_amnt: Label = $Menu_Container/HBoxContainer/VBoxContainer2/HBoxContainer2/music_v_amnt
@onready var sfxv_slider: HSlider = $Menu_Container/HBoxContainer/VBoxContainer2/HBoxContainer3/sfxv_slider
@onready var sfxv_amnt: Label = $Menu_Container/HBoxContainer/VBoxContainer2/HBoxContainer3/sfxv_amnt
@onready var mute: CheckBox = $Menu_Container/mute
@onready var background: AudioStreamPlayer2D = $background
@onready var toast: Label = $toast
@onready var toast_timer: Timer = $toast_timer

var cloud=null
var game = null

func _ready() -> void:
	spawn_timer.start(randf_range(0.8, 1.5))
	hail_timer.start(randf_range(0.8, 1.5))
	master_v_slider.value=GameManager.background_music_value
	music_v_slider.value=GameManager.background_music_value
	sfxv_slider.value=GameManager.sound_effects_value
	mute.button_pressed=GameManager.muted
	
	
func _on_apply_pressed() -> void:
	toast.visible=true
	toast_timer.start(0.7)
	
func _on_toast_timer_timeout() -> void:
	toast.visible=false	

func update_sound():
	master_v_amnt.text=str(master_v_slider.value)
	music_v_amnt.text=str(music_v_slider.value)
	sfxv_amnt.text=str(sfxv_slider.value)
	GameManager.background_music_value=float(music_v_amnt.text)
	GameManager.sound_effects_value=float(sfxv_amnt.text)
	background.volume_db=linear_to_db(GameManager.background_music_value/100)
	update_sounds()

func _on_spawn_timer_timeout() -> void:
	var choice = randf_range(1, 5)
	if choice<3:
		var bread_spawn = bread.instantiate()
		cloud=get_tree().get_first_node_in_group("menu_cloud")
		bread_spawn.global_position=cloud.global_position
		add_child(bread_spawn)
	else:
		var hail_spawn = hail.instantiate()
		cloud=get_tree().get_first_node_in_group("menu_cloud")
		cloud.hail_face()
		hail_spawn.global_position=cloud.global_position
		add_child(hail_spawn)
		
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")
	
func _on_mute_toggled(toggled_on: bool) -> void:
	var audio_bus_index=AudioServer.get_bus_index("Master")
	if toggled_on==true:
		GameManager.muted=true
		AudioServer.set_bus_mute(audio_bus_index, true)
	else:
		GameManager.muted=false
		AudioServer.set_bus_mute(audio_bus_index, false)
	
func update_sounds():
	game=get_tree().get_first_node_in_group("game")
	if game:
		game.update_sound()
		
func master_volume():
	music_v_slider.value=master_v_slider.value
	sfxv_slider.value=master_v_slider.value
	master_v_amnt.text=str(master_v_slider.value)
	music_v_amnt.text=str(master_v_slider.value)
	sfxv_amnt.text=str(master_v_slider.value)
	
	GameManager.background_music_value=float(music_v_amnt.text)
	GameManager.sound_effects_value=float(sfxv_amnt.text)
	background.volume_db=linear_to_db(GameManager.background_music_value/100)
	update_sounds()
	
func _on_master_v_slider_value_changed(_value: float) -> void:
	master_volume()

func _on_music_v_slider_value_changed(_value: float) -> void:
	update_sound()

func _on_sfxv_slider_value_changed(_value: float) -> void:
	update_sound()
