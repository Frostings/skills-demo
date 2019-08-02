extends TargetQueue

class_name Dash2

export (float, 0, 10, 0.1) var speed := 0.1
export (float, 0, 2, 0.1) var delay := 0.0

func _init( _actor:Node2D ).(_actor) -> void:
	var effect: Effect = DashEffect.new( cast_range, speed, delay ) 
	add_effect( effect )
	effect = ShieldEffect.new( actor, 1, 1 )
	add_effect( effect )

#func use( actor: KinematicBody2D, mouse_posn: Vector2, target: Node2D ) -> int:
#	var skill_status: int = .use( actor, mouse_posn, target )
#
#	if skill_status != SkillStatus.USED:
#		return skill_status
#	print("using")
#	play_effects( actor, mouse_posn, target )
#	return skill_status
#
