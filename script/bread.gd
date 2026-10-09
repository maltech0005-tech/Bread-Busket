extends Node2D
@onready var sprite: AnimatedSprite2D = $Sprite

var Speed = 200

func _ready() -> void:
	add_to_group("bread")

func _process(delta: float) -> void:
	global_position.y+=Speed*delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("basket"):
		queue_free()

func make_hail():
	sprite.play("hail")
