extends GroundImmediate

class_name BuffSkill

export (float, 0, 20, 0.25) var buff_duration: float
export (float, 0, 5, 0.25) var channel_time: float
export (float, 0, 1000, 5) var _radius: float
export (float, 0, 2, 0.1) var delay := 0.0


#func _init( _actor:Node2D ).( _actor ) -> void:
#	var effect = AOEEffect.new( _actor, _radius, delay )
#	add_child( effect )


#func use( _mouse_posn: Vector2 = Vector2(), _target: Node2D = null ) -> int:
#	var skill_status: int = .use( _mouse_posn )
#	if skill_status != SkillStatus.USED:
#		return skill_status
#
#	play_effects( _mouse_posn, _target )
#	return skill_status
