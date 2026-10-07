extends Node2D
@export var bread: PackedScene
@onready var spawn_timer: Timer = $spawn_timer

var cloud = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cloud=get_tree().get_first_node_in_group("cloud")
	spawn_timer.start(randf_range(1, 3))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass	

func _on_left_pressed() -> void:
	Input.action_press("left")

func _on_right_pressed() -> void:
	Input.action_press("right")
	
func _on_spawn_timer_timeout() -> void:
	var bread_spawn = bread.instantiate()
	cloud=get_tree().get_first_node_in_group("cloud")
	bread_spawn.global_position=cloud.global_position
	add_child(bread_spawn)
