# An Actor is an Entity that can use skills to interact with other Entities
extends Entity
class_name Actor


var movement_queued := false
var queued_target: Entity
var queued_position: Vector2
var queued_skill: Skill
var target: Vector2
var velocity: Vector2


func cancel_casting() -> void:
	queued_target = null
	queued_skill = null
	#queued_position = null


# Our own move_and_slide function to help us with collisions
func move_slide( _delta: float ) -> void:
	velocity = (target - position).normalized() * final_speed
	if (target - get_position()).length() > 5 and movement_queued:
		velocity = move_and_slide( velocity )
		for i in range( get_slide_count() ):
			var collision: KinematicCollision2D = get_slide_collision( i )
			if collision:
				pass


# queue a target to attack or use a skill on
func queue_target( _target, _skill: Skill ) -> void:
	movement_queued = true
	queued_target = _target
	queued_skill = _skill


func queue_position( posn: Vector2, _skill: Skill ) -> void:
	movement_queued = true
	queued_position = posn
	queued_skill = _skill


func _use_skill( skill: Skill, posn: Vector2, _target ) -> int:
	var skill_status = skill.use( self, posn, _target )
	
	match skill_status:
		Skill.SkillStatus.USED:
			movement_queued = false
			queued_target = null
		Skill.SkillStatus.QUEUED:
			movement_queued = true
			queued_target = _target
		_:
			pass
	
	return skill_status
