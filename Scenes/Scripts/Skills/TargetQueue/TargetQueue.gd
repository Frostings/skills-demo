extends Skill

# Target Queue must have selected target. It will walk towards if not in range and queue the skill
class_name TargetQueue

#export (float, 0, 1000, 5) var _skill_range := 150


func _init( actor: Node2D ).( actor ) -> void:
	pass


func use( actor: KinematicBody2D, mouse_posn: Vector2, target: Node2D ) -> int:
	var skill_status: int = .use( actor, mouse_posn, target )
	
	if skill_status != SkillStatus.USED and skill_status != SkillStatus.QUEUED:
		return skill_status
	
	if !target:
		return SkillStatus.NO_AVAILABLE_TARGETS
	
	# I am in range. Use the skill
	if is_in_range( actor, target ):
		play_effects( actor, mouse_posn, target )
		return skill_status
	
	# I am not in range. I must queue walking towards my target
	else:
		actor.queue_target( target, cast_range, self )
		return SkillStatus.QUEUED

