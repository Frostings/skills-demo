extends BuffEffect
class_name SpeedBuff


export (int, 0, 50, 5) var _flat_speed: int setget set_flat_speed, get_flat_speed
export (float, 0, 2, 0.01) var _scaling_speed := 1.0 setget set_scaling_speed, get_scaling_speed

# Play the effect
func play( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> void:
	if !.play( _actor, _mouse_posn, _target ):
		return
	_target.add_speed( _flat_speed, _scaling_speed )
	

# End the effect. generally it's the inverse operation of play()
func end( _target: Entity ) -> void:
	_target.remove_speed( _flat_speed, _scaling_speed )
	.end( _target )


# Setgetters -------------------------------------- #
func set_flat_speed( value: int ) -> void:
	_flat_speed = value
	

func get_flat_speed() -> int:
	return _flat_speed
	

func set_scaling_speed( value: float ) -> void:
	_scaling_speed = value
	

func get_scaling_speed() -> float:
	return _scaling_speed
