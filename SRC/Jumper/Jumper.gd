extends KinematicBody2D

export (float) var knockback_intensity: = 1000.0
export (Vector2) var knockback_direction: = Vector2.UP

func _on_Trigger_body_entered(body: PhysicsBody2D) -> void:	
	if body.has_method("_apply_knockback"):
		body._apply_knockback(knockback_direction, knockback_intensity)
		$Anim.play("Bounce")
		print("Entrou")
