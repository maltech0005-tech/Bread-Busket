extends Node2D

var Speed = 200

func _ready() -> void:
	add_to_group("bread")

func _process(delta: float) -> void:
	global_position.y+=Speed*delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("basket"):
		queue_free()

#func _on_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	#if body.is_in_group("basket"):
		#print("2")
		#queue_free()

#func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	#if area.is_in_group("basket"):
		#print("1")
		#queue_free()
