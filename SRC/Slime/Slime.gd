extends Actor

export (float) var jump_power: = -500.0
export (int) var damage: = 1
export (bool) var suicide: = false

var _damage_knockback: = 500.0
var _direction: = -1.0

func _physics_process(delta: float) -> void:
	_handle_movement()


func _handle_movement():
	if is_on_wall():
		_direction *= -1
	elif not $RayDown.is_colliding() and not suicide:
		_direction *= -1
	
	_motion.x = _direction * move_speed


func _on_DamageArea_body_entered(body: PhysicsBody2D):
	if body.has_method("_take_damage") and body.has_method("_apply_knockback"):
		body._take_damage(damage)
		
		var knockback_dir: = Vector2.ZERO
		if body.global_position.x < global_position.x:
			knockback_dir = Vector2(-1, 0)
		elif body.global_position.x > global_position.x:
			knockback_dir = Vector2(1, 0)
		
		body._apply_knockback(knockback_dir, _damage_knockback)

func _on_Stomp_body_entered(body: PhysicsBody2D):
	body._apply_knockback(Vector2(0, -1), 1000)
	queue_free()