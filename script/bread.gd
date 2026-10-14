extends Node2D
@onready var sprite: AnimatedSprite2D = $Sprite

var Speed = 200
var game = null

func _ready() -> void:
	add_to_group("bread")
	game=get_tree().get_first_node_in_group("game")
	
func _process(delta: float) -> void:
	global_position.y+=Speed*delta
	if global_position.y>462:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("basket"):
		game=get_tree().get_first_node_in_group("game")
		game.playbread()
		queue_free()

func make_hail():
	sprite.play("hail")
