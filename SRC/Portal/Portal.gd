extends Area2D

export (String) var path_next_level
export (String) var label_name

func _ready() -> void:
	$Label.text = label_name

func _on_Portal_body_entered(body: PhysicsBody2D) -> void:
	get_tree().change_scene(path_next_level)