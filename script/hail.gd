extends Area2D

var Speed =  200
var game = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("hail")
	game=get_tree().get_first_node_in_group("game")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.y+=Speed*delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("basket"):
		game=get_tree().get_first_node_in_group("game")
		game.playhail()
		queue_free()
