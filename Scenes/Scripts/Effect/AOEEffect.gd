extends Effect

class_name AOEEffect

var aoe_range: float
var delay: float
var status


func _init( _actor: Node2D, _aoe_range: float, _delay: float ).( _actor, Effect.Type.AOE ) -> void:
	aoe_range = _aoe_range
	delay = _delay
	

# Play the effect
func play( _posn: Vector2, _target: Node2D = null ) -> void:
	pass
	
