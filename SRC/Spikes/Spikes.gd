extends Area2D
class_name Spikes

export (int) var damage: = 1.0

var _knockback_intensity: = 800.0

func _on_Spikes_body_entered(body: PhysicsBody2D) -> void:
	if body.has_method("_take_damage") and body.has_method("_apply_knockback"):
		var knockback_direction: = Vector2(0, -1)
		body._take_damage(damage)
		body._apply_knockback(knockback_direction, _knockback_intensity)
