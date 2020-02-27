extends Area2D

export (int) var damage: = 3.0
export (float) var move_speed: = 150.0

var _motion: = Vector2.ZERO

func _process(delta: float) -> void:
	position += _motion.normalized() * move_speed * delta


func _setup(point_direction: Vector2) -> void:
	_motion = point_direction