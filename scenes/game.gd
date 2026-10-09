extends Node2D
@export var bread: PackedScene
@export var hail: PackedScene
@onready var spawn_timer: Timer = $spawn_timer
@onready var hail_timer: Timer = $hail_timer
@onready var game_over: Node2D = $CanvasLayer/GameOver
@onready var life_value: AnimatedSprite2D = $CanvasLayer/life_value

var cloud = null
var basket = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("game")
	cloud=get_tree().get_first_node_in_group("cloud")
	basket=get_tree().get_first_node_in_group("basket")
	spawn_timer.start(randf_range(0.8, 1.5))
	hail_timer.start(randf_range(0.8, 1.5))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass	

func _on_left_pressed() -> void:
	Input.action_press("left")

func _on_right_pressed() -> void:
	Input.action_press("right")
	
func _on_spawn_timer_timeout() -> void:
	var choice = randf_range(1, 5)
	if choice<3:
		var bread_spawn = bread.instantiate()
		cloud=get_tree().get_first_node_in_group("cloud")
		bread_spawn.global_position=cloud.global_position
		add_child(bread_spawn)
	else:
		var hail_spawn = hail.instantiate()
		cloud=get_tree().get_first_node_in_group("cloud")
		cloud.hail_face()
		hail_spawn.global_position=cloud.global_position
		add_child(hail_spawn)

func _on_hail_timer_timeout() -> void:
	pass

func check_gameover():
	basket=get_tree().get_first_node_in_group("basket")
	var life = basket.life
	if life==0:
		get_tree().paused=true
		game_over.visible=true
	
func _on_help_pressed() -> void:
	pass # Replace with function body.

	
func _on_quit_pressed() -> void:
	get_tree().paused=false
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func check_life():
	basket=get_tree().get_first_node_in_group("basket")
	var life = basket.life
	if life == 10:
		life_value.play("10")
	elif life == 9:
		life_value.play("9")
	elif life == 8:
		life_value.play("8")
	elif life == 7:
		life_value.play("7")
	elif life == 6:
		life_value.play("6")
	elif life == 5:
		life_value.play("5")
	elif life == 4:
		life_value.play("4")
	elif life == 3:
		life_value.play("3")
	elif life == 2:
		life_value.play("2")
	elif life == 1:
		life_value.play("1")
	elif life == 0:
		life_value.play("0")
