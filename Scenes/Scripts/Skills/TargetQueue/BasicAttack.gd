extends TargetQueue

class_name BasicAttack


func _init( _actor: Node2D ).(_actor):
	pass


func use( actor: KinematicBody2D, mouse_posn: Vector2, _target: Node2D ) -> int:
	var skill_status: int = .use( actor, mouse_posn, _target )
	
	if skill_status != SkillStatus.USED:
		return skill_status
	
	print( "ATTACK" )
	return skill_status
	
