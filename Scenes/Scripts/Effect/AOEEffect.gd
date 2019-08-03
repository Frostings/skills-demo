extends Effect

class_name AOEEffect

export (float, 0, 500, 5) var _aoe_radius: float = 100.0
var status


# Play the effect
func play( _posn: Vector2, _target: Node2D = null ) -> void:
	pass
	

func set_aoe_radius( value: float ) -> void:
	_aoe_radius = stepify( value, 0.01 )


func get_aoe_radius() -> float:
	return _aoe_radius
