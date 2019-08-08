# GroundImmediate is a skill that will cast irrespective of the mouse position.
extends Skill
class_name GroundImmediate, "res://Assets/CustomIcons/GroundImmediate.png"


func _ready() -> void:
	pass


func use( actor: Entity, mouse_posn: Vector2, _target: Entity ) -> int:
	var skill_status: int = .use( actor, mouse_posn, _target )
	if skill_status != SkillStatus.USED:
		return skill_status
	
	play_effects( actor, mouse_posn, _target )
	return skill_status
