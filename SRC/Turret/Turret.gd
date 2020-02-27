extends KinematicBody2D

export (PackedScene) var bullet 

var _target: = null
var _can_shot: = true

onready var _turret: = $Pivot/Head
onready var _shot_pos: = $Pivot/Head/ShotPos
onready var _pointer: = $Pivot/Head/RayCast2D
onready var _cooldown: = $Timer

func _process(delta: float) -> void:
	if is_instance_valid(_target):
		_handle_aim(_target, -90)
		
	_handle_shooting()


func _handle_shooting() -> void:
	if _pointer.is_colliding() and _pointer.get_collider().is_in_group("Player") and _can_shot:
		$Anim.play("Shoting")
		var temp = bullet.instance()
		add_child(temp)
		
		temp.global_position = _shot_pos.global_position
		temp.rotation_degrees = _turret.rotation_degrees + 180
		temp._setup((_pointer.get_collision_point() - position) * -1.0)
		
		_can_shot = false
		_cooldown.start()



func _handle_aim(target: Node2D, deg_offset: float):
	var direction: = Vector2.ZERO
	
	if is_instance_valid(target):
		direction = target.position - position
	else:
		direction = lerp(_turret.rotation_degrees, 0, 0.08)
	
	var angle: = rad2deg(atan2(direction.y - 32, direction.x))
	_turret.rotation_degrees = angle + deg_offset


func _on_Trigger_body_entered(body: PhysicsBody2D) -> void:
	_target = body


func _on_Timer_timeout() -> void:
	_can_shot = true
