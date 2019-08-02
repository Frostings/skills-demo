extends TargetQueue

class_name Dash2

export (float, 0, 10, 0.1) var speed := 0.1
export (float, 0, 2, 0.1) var delay := 0.0


func _init( _actor:Node2D ).( _actor ) -> void:
	var effect: Effect = DashEffect.new( _actor, cast_range, speed, delay )
	add_effect( effect )
	effect = ShieldEffect.new( _actor, _actor, 1, 1 )
	add_effect( effect )

