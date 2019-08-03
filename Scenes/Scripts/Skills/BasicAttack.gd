extends TargetQueue

class_name BasicAttack
	
export (bool) var melee = true setget , is_melee

func use( mouse_posn: Vector2, _target: Node2D = null ) -> int:
	var skill_status: int = .use( mouse_posn, _target )
	
	if skill_status != SkillStatus.USED:
		return skill_status
	
	# TODO:
	print( "ATTACK" )
	return skill_status


func is_melee() -> bool:
	return melee
	
	
