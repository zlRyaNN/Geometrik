extends Actor
class_name Player

enum STATE {
	INVENCIBLE,
	SPEEDER,
	DEFAULT
}

export (float) var jump_power: = -950.0
export (float) var max_jumps: = 2.0
export (STATE) var state: = STATE.DEFAULT

var _jumps: = max_jumps
var _jump_smooth_factor: = 0.5

const _ACCELERATION: = 50.0

var _default_move_speed: = 0.0
var _buffed_move_speed: = 0.0

func _ready() -> void:
	_default_move_speed = move_speed
	_buffed_move_speed = move_speed * 1.5


func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_handle_rotation(30.0)
	_handle_jumping()


func _process(delta: float) -> void:
	_handle_state()
	
	if hit_points <= 0:
		_die()


func _die() -> void:
	$Anim.play("Died")


func _take_damage(amount: int) -> void:
	if amount > 0:
		if amount > hit_points:
			_die()
		else:
			if not state == STATE.INVENCIBLE:
				$Anim.play("Damaged")
				hit_points -= amount


func _handle_movement(delta: float) -> void:
	var left: = int(Input.is_action_pressed("ui_left"))
	var right: = int(Input.is_action_pressed("ui_right"))
	var weight: = 0.2
	
	if right:
		_motion.x = min(_motion.x + _ACCELERATION, move_speed)
	elif left:
		_motion.x = max(_motion.x - _ACCELERATION, -move_speed)
	else:
		_motion.x = lerp(_motion.x, 0, weight)


func _apply_knockback(direction: Vector2, intensity: float) -> void:
	_motion = direction * intensity


func _handle_rotation(degrees: float) -> void:
	var left: = int(Input.is_action_pressed("ui_left"))
	var right: = int(Input.is_action_pressed("ui_right"))
	
	var rot_deg: = float($Pivot.rotation_degrees)
	var _target_rotation: = 0.0
	var weight: = 0.15
	
	if _motion.y < 0:
		if left:
			_target_rotation = degrees
		if right:
			_target_rotation = -degrees
	elif _motion.y > 0:
		if left:
			_target_rotation = -degrees
		if right:
			_target_rotation = degrees
	else:
		_target_rotation = 0
	
	$Pivot.rotation_degrees = lerp(rot_deg, _target_rotation, weight)


func _handle_jumping() -> void:
	var jump_pressed: = int(Input.is_action_just_pressed("ui_up"))
	var jump_released: = int(Input.is_action_just_released("ui_up"))
	
	if is_on_floor():
		_jumps = max_jumps
	
	if jump_pressed and _jumps > 0:
		_motion.y = jump_power
		_jumps -= 1
	elif jump_released and _motion.y < 0:
		_motion.y *= _jump_smooth_factor


func _handle_state() -> void:
	if state == STATE.INVENCIBLE:
		$Invencible.emitting = true
	elif state == STATE.SPEEDER:
		$Speed.emitting = true
		move_speed = _buffed_move_speed
	elif state == STATE.DEFAULT:
		$Invencible.emitting = false
		$Speed.emitting = false
		move_speed = _default_move_speed


func _on_CoolDown_timeout() -> void:
	state = STATE.DEFAULT


func _on_Speed_collected(power) -> void:
	state = STATE.SPEEDER
	$CoolDown.start()


func _on_Shield_collected(power) -> void:
	state = STATE.INVENCIBLE
	$CoolDown.start()
