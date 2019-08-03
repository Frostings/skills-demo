extends TargetQueue

class_name BasicAttack


func _init() -> void:
	pass
	

func use( mouse_posn: Vector2, _target: Node2D = null ) -> int:
	var skill_status: int = .use( mouse_posn, _target )
	
	if skill_status != SkillStatus.USED:
		return skill_status
	
	# TODO:
	print( "ATTACK" )
	return skill_status
	
