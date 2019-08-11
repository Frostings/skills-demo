extends Actor
class_name Player


onready var BASIC_A: Skill = $BasicAttack
onready var SKILL_Q: Skill = $SkillQ
onready var SKILL_W: Skill = $SkillW
onready var SKILL_E: Skill = $SkillE

var hovered_target: Entity


func _ready() -> void:
	pass
	

func _physics_process( _delta: float ) -> void:
	var mouse_posn = get_global_mouse_position()
	
	if Input.is_action_pressed("move_command"):
		target = get_global_mouse_position()
		if hovered_target:
			if _use_skill( BASIC_A, mouse_posn, hovered_target ):
				pass
		else:
			movement_queued = true
			cancel_casting()
	
	if Input.is_action_just_pressed("skill_q"):
		if _use_skill( SKILL_Q, mouse_posn, hovered_target ):
			pass
	
	if Input.is_action_just_pressed("skill_w"):
		if _use_skill( SKILL_W, mouse_posn, hovered_target ):
			pass
	
	if Input.is_action_just_pressed("skill_e"):
		if _use_skill( SKILL_E, mouse_posn, hovered_target ):
			pass
	
	# TODO: move this to Entity
	if movement_queued: #if queued_target or queued_position:
		if queued_skill:
			if queued_target:
				target = queued_target.position
			else:
				target = queued_position
			var skill_status: int = _use_skill( queued_skill, queued_position, queued_target )
			if skill_status == Skill.SkillStatus.USED:
				queued_skill = null
				#movement_queued = false
	if Input.is_action_just_pressed("stop"):
		movement_queued = false
	
	# Reset my camera to be on top of the Player
	if Input.is_action_pressed("reset_camera"):
		$Camera2D.align()

	move_slide( _delta )


func _on_enemy_hovered( _target: Entity ) -> void:
	hovered_target = _target
	

func _on_enemy_unhovered( _target: Entity ) -> void:
	if hovered_target == _target:
		hovered_target = null
