extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var life = 10

var game = null

func _ready() -> void:
	add_to_group("basket")
	game=get_tree().get_first_node_in_group("game")

func _physics_process(_delta: float) -> void:
	
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("hail"):
		if life>0:
			life-=1
			game=get_tree().get_first_node_in_group("game")
			game.check_life()
			game.check_gameover()
		else:
			game.check_gameover()
	elif area.is_in_group("bread"):
		GameManager.score+=1
		game=get_tree().get_first_node_in_group("game")
		game.update_stats()
