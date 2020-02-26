extends Node2D

func _process(delta: float) -> void:
	if not is_instance_valid($Player):
		get_tree().reload_current_scene()