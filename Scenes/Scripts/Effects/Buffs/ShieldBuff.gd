extends BuffEffect
class_name ShieldBuff

signal shield_added
signal shield_expired


export (int, 10) var _shield_amount: int = 1 setget set_shield_amount, get_shield_amount


# Play the effect
func play( _actor: PhysicsBody2D = null, _mouse_posn: Vector2 = Vector2(), _target: PhysicsBody2D = null ) -> void:
	if !.play():
		return
	emit_signal( "shield_added", _shield_amount )
	#.play()
	

# End the effect. generally it's the inverse operation of play()
func end() -> void:
	.end()
	emit_signal( "shield_expired", _shield_amount * ( stacks - _stacks_available ) )



# Setgetters -------------------------------------- #
func get_shield_amount() -> int:
	return _shield_amount
	

func set_shield_amount( value: int ) -> void:
	_shield_amount = value
	

