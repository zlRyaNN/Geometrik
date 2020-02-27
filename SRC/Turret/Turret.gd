extends KinematicBody2D

export (PackedScene) var bullet 

var _target: = null
var _can_shot: = true

func _process(delta: float) -> void:
	if is_instance_valid(_target):
		_handle_aim(_target, -90)
	
	_handle_shooting()


func _handle_shooting() -> void:
	if $Pivot/Head/RayCast2D.is_colliding() and _can_shot:
		var temp = bullet.instance()
		add_child(temp)
		temp.global_position = $Pivot/Head.global_position
		temp.rotation_degrees = $Pivot/Head.rotation_degrees + 180
		temp._setup(($Pivot/Head/RayCast2D.get_collision_point() - position) * -1.0)
		_can_shot = false
		$Timer.start()


func _handle_aim(target: Node2D, deg_offset: float):
	var direction: = target.position - position
	var angle: = rad2deg(atan2(direction.y - 32, direction.x))
	$Pivot/Head.rotation_degrees = angle + deg_offset


func _on_Trigger_body_entered(body: PhysicsBody2D) -> void:
	_target = body


func _on_Timer_timeout() -> void:
	_can_shot = true
