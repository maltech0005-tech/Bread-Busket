extends Area2D

var Speed =  200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("hail")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.y+=Speed*delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("basket"):
		queue_free()
