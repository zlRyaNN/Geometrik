extends KinematicBody2D

enum STATE {
	OPENING,
	CLOSING,
	STOPPED
}

export (STATE) var state: = STATE.STOPPED

func _process(delta: float) -> void:
	_handle_state()


func _handle_state() -> void:
	if state == STATE.OPENING and not $Anim.current_animation == "Closing":
		$Anim.play("Opening")
		state = STATE.STOPPED
	elif state == STATE.CLOSING and not $Anim.current_animation == "Opening":
		$Anim.play("Closing")
		state = STATE.STOPPED


func _on_Trigger_area_entered(area: Area2D) -> void:
	state = STATE.OPENING


func _on_Trigger_area_exited(area: Area2D) -> void:
	state = STATE.CLOSING
