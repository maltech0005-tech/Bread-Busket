extends Node2D
@export var bread: PackedScene
@export var hail: PackedScene
@onready var spawn_timer: Timer = $spawn_timer
@onready var hail_timer: Timer = $hail_timer

var cloud=null

func _ready() -> void:
	spawn_timer.start(randf_range(0.8, 1.5))
	hail_timer.start(randf_range(0.8, 1.5))

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_help_pressed() -> void:
	pass # Replace with function body.

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()

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
		
