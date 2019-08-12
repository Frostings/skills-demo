extends Effect
class_name DamageEffect


export (int, 1, 100, 1) var damage := 1 setget set_damage, get_damage


func play( _actor: Entity, _posn: Vector2, _target: Entity ) -> void:
	_target.take_damage( damage )



# Setgetters -------------------------------------- #
func set_damage( value: int ) -> void:
	damage = value
	

func get_damage() -> int:
	return damage
