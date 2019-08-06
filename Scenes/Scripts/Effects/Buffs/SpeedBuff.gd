extends BuffEffect
class_name SpeedBuff

signal speed_added
signal speed_expired


export (float, 0, 50, 5) var _flat_speed: float setget set_flat_speed, get_flat_speed
export (float, 0, 2, 0.01) var _scaling_speed := 1.0 setget set_scaling_speed, get_scaling_speed

# Play the effect
func play( _actor: PhysicsBody2D = null, _mouse_posn: Vector2 = Vector2(), _target: PhysicsBody2D = null ) -> void:
	if !.play():
		return
	emit_signal( "speed_added", _flat_speed, _scaling_speed )
	

# End the effect. generally it's the inverse operation of play()
func end() -> void:
	# Fully reset the buff
	emit_signal( "speed_expired", _flat_speed * ( stacks - _stacks_available ), _scaling_speed * ( stacks - _stacks_available ) )
	.end()


# Setgetters -------------------------------------- #
func set_flat_speed( value: float) -> void:
	_flat_speed = value
	

func get_flat_speed() -> float:
	return _flat_speed
	

func set_scaling_speed( value: float ) -> void:
	_scaling_speed = value
	

func get_scaling_speed() -> float:
	return _scaling_speed
