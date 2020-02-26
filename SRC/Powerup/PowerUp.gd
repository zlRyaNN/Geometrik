extends Area2D
class_name PowerUp

enum TYPE {
	SHIELD,
	SPEED
}

signal collected(power)

export (TYPE) var type: = TYPE.SHIELD

func _on_PowerUp_area_entered(area: Area2D) -> void:
	emit_signal("collected", self)
	queue_free()
