extends BuffEffect

class_name ShieldEffect


export (int, 10) var _shield_amount: int = 1
	

# Play the effect
func play( _mouse_posn: Vector2 = Vector2(), target: Node2D = null ) -> void:
	_target.add_shield_amount( _shield_amount )
	.play()
	print( "yes" )

# End the effect. generally it's the inverse operation of play()
func end() -> void:
	_target.remove_shield_amount( _shield_amount )
	print( "no" )

func get_shield_amount() -> int:
	return _shield_amount
	

func set_shield_amount( value: int ) -> void:
	_shield_amount = value
	

