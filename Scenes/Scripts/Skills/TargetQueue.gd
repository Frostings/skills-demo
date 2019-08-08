# TargetQueue must have selected target. It will walk towards the target if not in range and queue the skill.
extends Skill
class_name TargetQueue, "res://Assets/CustomIcons/TargetQueue.png"


func use( actor: Entity, mouse_posn: Vector2, target: Entity ) -> int:
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

