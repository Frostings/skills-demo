# TargetQueue must have selected target. It will walk towards the target if not in range and queue the skill.
extends Skill
class_name GroundQueue, "res://Skills/Assets/CustomIcons/TargetQueue.png"


# GroundQueue does not depend on _target
func use( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> int:
	var skill_status: int = .use( _actor, _mouse_posn, null )
	
	if skill_status != SkillStatus.USED and skill_status != SkillStatus.QUEUED:
		return skill_status
	
	if skill_status != SkillStatus.USED:
		_actor.queue_position( _mouse_posn, self )
	
	return skill_status
