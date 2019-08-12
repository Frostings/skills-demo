# GroundImmediate is a skill that will cast irrespective of the mouse position.
extends Skill
class_name GroundInstant, "res://Skills/Assets/CustomIcons/GroundInstant.png"


func _ready() -> void:
	pass


func use( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> int:
	# GroundInstant does not care about the target. Any effects will be done to actor.
	var skill_status: int = .use( _actor, _mouse_posn, _actor )
	if skill_status != SkillStatus.USED:
		return skill_status
	
	play_effects( _actor, _mouse_posn, _actor )
	return skill_status
