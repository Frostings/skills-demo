extends KinematicBody2D

class_name Player

export (int, 0, 500, 5) var speed := 200

var target := Vector2()
var velocity := Vector2()
var queued_target: Node2D
var hovered_target: Node2D
var queued_cast_range: float
var queued_skill: Skill
var shield_amount: int = 0

onready var BASIC_A: Skill = BasicAttack.new( self )
onready var SKILL_Q: Skill = Dash.new( self )
onready var movement_queued = false


func _ready() -> void:
	add_child( SKILL_Q )
	add_child( BASIC_A )
	pass
	

func _physics_process( _delta: float ) -> void:
	
	if Input.is_action_pressed("move_command"):
		target = get_global_mouse_position()
		if hovered_target:
			if _use_skill( BASIC_A, hovered_target ):
				pass
		else:
			movement_queued = true
			queued_target = null
			queued_skill = null
	
	if Input.is_action_just_pressed("skill_q"):
		if _use_skill( SKILL_Q, hovered_target ):
			pass
	
	if queued_target:
		target = queued_target.get_position()
		if queued_skill:
			var skill_status: int = _use_skill( queued_skill, queued_target )
			if skill_status == Skill.SkillStatus.USED:
				queued_skill = null
				
	if Input.is_action_just_pressed("stop"):
		movement_queued = false
	
	# Reset my camera to be on top of the Player
	if Input.is_action_pressed("reset_camera"):
		$Camera2D.align()

	move_slide( _delta )
	

# queue a target to attack or use a skill on
func queue_target( _target: Node2D, _cast_range: float, _skill:TargetQueue ) -> void:
	movement_queued = true
	queued_target = _target
	queued_cast_range = _cast_range
	queued_skill = _skill
	

# Our own move_and_slide function to help us with collisions
func move_slide( _delta: float ) -> void:
	velocity = (target - get_position()).normalized() * speed
	if (target - get_position()).length() > 5 and movement_queued:
		velocity = move_and_slide( velocity )
		for i in range( get_slide_count() ):
			var collision: KinematicCollision2D = get_slide_collision( i )
			if collision:
				pass
	

# Use a skill on a target
func _use_skill( skill:Skill, _target: Node2D ) -> int:
	var mouse_posn: Vector2 = get_global_mouse_position()
	var skill_status = skill.use( mouse_posn, _target )
	
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
	

func add_shield_amount( _shield_amount: int ) -> void:
	shield_amount += _shield_amount


func remove_shield_amount( _shield_amount: int ) -> void:
	shield_amount -= _shield_amount
	if shield_amount < 0:
		shield_amount = 0
	

func is_crowd_controlled() -> bool:
	return false
	

func _on_enemy_hovered( _target: Node2D ) -> void:
	hovered_target = _target
	

func _on_enemy_unhovered( _target: Node2D ) -> void:
	if hovered_target == _target:
		hovered_target = null
	
