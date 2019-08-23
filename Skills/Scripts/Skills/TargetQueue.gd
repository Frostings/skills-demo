# TargetQueue must have selected target. It will walk towards the target if not in range and queue the skill.
extends Skill
class_name TargetQueue, "res://Skills/Assets/CustomIcons/TargetQueue.png"


signal used


# TargetQueue does not depend on _mouse_posn
func use( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> int:
	var skill_status: int = .use( _actor, _mouse_posn, _target )
	
	if skill_status != SkillStatus.USED and skill_status != SkillStatus.QUEUED:
		return skill_status
	
	if !_target:
		return SkillStatus.NO_AVAILABLE_TARGETS
	
	if skill_status != SkillStatus.USED:
		_actor.queue_target( _target, self )
	else:
		emit_signal("used")
	return skill_status
