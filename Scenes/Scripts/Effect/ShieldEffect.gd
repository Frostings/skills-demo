extends BuffEffect

class_name ShieldEffect

var shield_amount: int


func _init( _target:Node2D, duration: float, _shield_amount:int ).( _target, duration ) -> void:
	shield_amount = _shield_amount
	

# Play the effect
func play( _actor: KinematicBody2D = null, _mouse_posn: Vector2 = Vector2(), _target: Node2D = null ) -> void:
	target.add_shield_amount( shield_amount )
	.play()


# End the effect. generally it's the inverse operation of play()
func end() -> void:
	target.remove_shield_amount( shield_amount )
