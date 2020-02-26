extends Area2D

var _target: = null
var _offset: = Vector2(0, -16)
var _weight: = 0.2

func _process(delta: float) -> void:
	if is_instance_valid(_target):
		position = lerp(position, (_target.position + _offset), _weight)
	else:
		_target = null


func _on_Key_body_entered(body: PhysicsBody2D) -> void:
	_target = body
