# TargetQueue must have selected target. It will walk towards the target if not in range and queue the skill.
extends Skill
class_name GroundQueue, "res://Assets/CustomIcons/TargetQueue.png"


# GroundQueue does not depend on _target
func use( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> int:
	var skill_status: int = .use( _actor, _mouse_posn, null )
	
	if skill_status != SkillStatus.USED and skill_status != SkillStatus.QUEUED:
		return skill_status
	
	# I am in range. Use the skill
	if skill_status == SkillStatus.USED:
		play_effects( _actor, _mouse_posn, null )
	# I am not in range. I must queue walking towards my target
	else:
		_actor.queue_position( _mouse_posn, self )
	return skill_status
