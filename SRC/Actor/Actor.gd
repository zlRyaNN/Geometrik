extends KinematicBody2D
class_name Actor

export (float) var move_speed: = 0.0
export (int) var hit_points: = 0

const _GRAVITY: = 3000.0
const _FLOOR_NORMAL: = Vector2.UP

var _motion: = Vector2.ZERO

func _physics_process(delta: float) -> void:
	_motion.y += _GRAVITY * delta
	_motion = move_and_slide(_motion, _FLOOR_NORMAL)