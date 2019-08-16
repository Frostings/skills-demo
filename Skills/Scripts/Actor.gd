# An Actor is an Entity that can use skills to interact with other Entities
extends Entity
class_name Actor


# Flag for movement
var movement_queued := false

# My queued target. Can be null
var queued_target: Entity

# My queued location
var queued_position: Vector2

# My queued skill. It will play this once I reach my destination
var queued_skill: Skill


func cancel_casting() -> void:
	queued_target = null
	queued_skill = null
	movement_queued = false


# Our own move_and_slide function to help us with collisions
func move_slide( dest: Vector2, _delta: float ) -> void:
	if !movement_queued:
		return
	var velocity := (dest - position).normalized() * final_speed
	if ( dest - get_position() ).length() > 5:
		velocity = move_and_slide( velocity )
		for i in range( get_slide_count() ):
			var collision: KinematicCollision2D = get_slide_collision( i )
			if collision:
				pass
	else:
		movement_queued = false


# queue a target to attack or use a skill on
func queue_target( _target: Entity, _skill: Skill ) -> void:
	movement_queued = true
	queued_target = _target
	queued_skill = _skill


func queue_position( posn: Vector2, _skill: Skill ) -> void:
	movement_queued = true
	queued_target = null
	queued_position = posn
	queued_skill = _skill


func _use_skill( skill: Skill, posn: Vector2, _target: Entity ) -> int:
	var skill_status := skill.use( self, posn, _target )
	match skill_status:
		Skill.SkillStatus.USED:
			if !( skill is BasicAttack ):
				cancel_casting()
		Skill.SkillStatus.QUEUED:
			if _target:
				queue_target( _target, skill )
			else:
				queue_position( posn, skill )
		_:
			pass
	return skill_status
