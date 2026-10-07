extends CharacterBody2D

@onready var random_timer: Timer = $random_timer
@onready var spawn_timer: Timer = $spawn_timer
@export var bread: PackedScene

const JUMP_VELOCITY = -400.0
var init_pos: Vector2

var direction: int = -1
var speed = 3.0
var computing = false

func _ready() -> void:
	add_to_group("cloud")
	init_pos =global_position
	rand_move()
	spawn_timer.start(3)

func _physics_process(_delta: float) -> void:
	if position.x<70:
		direction=1
	if position.x>638:
		direction=-1
	velocity.x=direction*speed
	move_and_slide()
	
func rand_move():
	direction=[-1, 1].pick_random()
	speed = randf_range(100, 150)
	random_timer.start(randf_range(2.0,4.0))

func _on_random_timer_timeout() -> void:
	rand_move()

#func _on_spawn_timer_timeout() -> void:
	#var bread_spawn = bread.instantiate()
	#bread_spawn.global_position=Vector2.ZERO
	#add_child(bread_spawn)
	
