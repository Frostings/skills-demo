extends Node2D
class_name Skill, "res://Skills/Assets/CustomIcons/Skill.png"


signal cooldown_changed
signal skill_used
signal skill_charge_gained


enum SkillStatus {
	USED,
	ON_COOLDOWN,
	QUEUED,
	CROWD_CONTROLLED,
	NO_AVAILABLE_TARGETS,
}


export (int, "A", "Q", "W", "E", "R", "D") var id := 0 setget , get_id
export (float, 0, 500, 0.01) var cooldown := 1.0 setget set_cooldown
export (int, 1, 10) var charges := 1 setget set_charges
export (bool) var bypass_cc := false
export (float, 0, 1000, 1) var cast_range := 50.0
export (float, 0.01, 5, 0.01) var animation_delay := 0.01

var cooldown_timer: Timer
var animation_timer: Timer
var effects: Array
var available_charges: int
	

func _ready() -> void:
	available_charges = charges
	
	# Create the cooldown timer
	cooldown_timer = Timer.new()
	if cooldown_timer.connect( "timeout", self, "_on_cooldown_timer_timeout" ):
		print_debug( Utility.ERROR_SIGNAL )
	cooldown_timer.one_shot = false
	cooldown_timer.autostart = false
	cooldown_timer.wait_time = cooldown
	add_child( cooldown_timer )
	
	# Create the animation timer
	animation_timer = Timer.new()
	animation_timer.one_shot = true
	animation_timer.autostart = false
	animation_timer.wait_time = animation_delay
	add_child( animation_timer )


# Cancel the skill we're animating
func cancel() -> void:
	animation_timer.stop()


# Add an effect to the skill
# TODO: distinguish between different effects (when they go off)
# TODO: Deprecate?
func add_effect( _effect: Effect ) -> void:
	effects += [ _effect ]
	add_child( _effect )
	

# Play all my effects
func play_effects( actor: Entity, mouse_posn: Vector2, target: Entity ) -> void:
	for node in get_children():
		if node is Effect:
			node.play( actor, mouse_posn, target )
	

# General check to see if the skill is on cool down, or if I am crowd controlled
func use( actor: Entity, _mouse_posn: Vector2, target: Entity ) -> int:
	if !available_charges:
		return SkillStatus.ON_COOLDOWN
	if actor.silenced or actor.stunned and !bypass_cc:
		return SkillStatus.CROWD_CONTROLLED
	
	if target and !is_target_in_range( actor, target ):
		return SkillStatus.QUEUED
	
	if !target and !is_posn_in_range( actor, _mouse_posn ):
		return SkillStatus.QUEUED
	
	if animation_timer.is_connected( "timeout", self, "play_effects" ):
		animation_timer.disconnect( "timeout", self, "play_effects" )
	if animation_timer.connect( "timeout", self, "play_effects", [actor, _mouse_posn, target] ):
		print_debug( Utility.ERROR_SIGNAL )
	
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
	available_charges -= 1
	if animation_timer.is_stopped():
		animation_timer.start()
	emit_signal( "skill_used", self )
	return SkillStatus.USED
	

func is_target_in_range( actor: Entity, _target: Entity ) -> bool:
	if cast_range == 0.0:
		return true
	return ( _target.position - actor.position ).length() <= cast_range + _target.get_radius()
	

func is_posn_in_range( actor: Entity, _posn: Vector2 ) -> bool:
	if cast_range == 0.0:
		return true
	return ( _posn - actor.position ).length() <= cast_range


# Add a charge when my skill goes off cooldown
func _on_cooldown_timer_timeout() -> void:
	available_charges += 1
	if available_charges == charges:
		cooldown_timer.stop()
	emit_signal( "skill_charge_gained", self )
	

func is_on_cooldown() -> bool:
	return available_charges == 0
	

# Update my cooldown reduction. Called after equipping any item that gives cdr
func set_cooldown_reduction( cooldown_amount: float ) -> void:
	cooldown_timer.set_wait_time( cooldown * (1 - cooldown_amount) )
	


# Setgetters -------------------------------------- #
func set_cooldown( value: float ) -> void:
	cooldown = stepify( value, 0.01 )
	emit_signal( "cooldown_changed", cooldown )


func add_cooldown( value: float ) -> void:
	cooldown = max( 0.01, cooldown + value )


func set_charges( value: int ) -> void:
	charges = value


func get_id() -> int:
	return id
