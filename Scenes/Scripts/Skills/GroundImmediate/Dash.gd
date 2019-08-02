extends GroundImmediate

class_name Dash

export (float, 0, 1000, 5) var dash_range := 100
export (float, 0, 10, 0.1) var speed := 0.1
export (float, 0, 2, 0.1) var delay := 0.0

func _init() -> void:
	var effect: Effect = DashEffect.new( dash_range, speed, delay ) 
	add_effect( effect )


func use( actor: KinematicBody2D, mouse_posn: Vector2, _target: Node2D = null ) -> int:
	var skill_status: int = .use( actor, mouse_posn )
	
	if skill_status != SkillStatus.USED:
		return skill_status
	
	play_effects( actor, mouse_posn, _target )
	return skill_status
	
