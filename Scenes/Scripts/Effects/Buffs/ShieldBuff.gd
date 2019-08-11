extends BuffEffect
class_name ShieldBuff


export (int, 10) var _shield_amount: int = 1 setget set_shield_amount, get_shield_amount


# Play the effect
func play( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> void:
	if !.play( _actor, _mouse_posn, _target ):
		return
	_target.add_shield( _shield_amount )
#	if _target.connect( "damage_taken", self, "on_damage_taken" ):
#		print_debug( Utility.ERROR_SIGNAL )

# End the effect. generally it's the inverse operation of play()
func end( _target: Entity ) -> void:
	_target.remove_shield( _shield_amount )
	.end( _target )


#func on_damage_taken( amount: int ) -> void:
#	if _shield_amount - amount < 0:
#		_shield_amount = 0
		
# Setgetters -------------------------------------- #
func get_shield_amount() -> int:
	return _shield_amount
	

func set_shield_amount( value: int ) -> void:
	_shield_amount = value
	

