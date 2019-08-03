extends Node2D

class_name Skill

enum SkillStatus {
	USED,
	ON_COOLDOWN,
	QUEUED,
	CROWD_CONTROLLED,
	NO_AVAILABLE_TARGETS,
}

export (float, 0, 500, 0.25) var cooldown := 1.0
export (int, 1, 10) var charges := 1
export (bool) var bypass_cc := false
export (float, 0, 1000, 25) var cast_range := 200.0

var cooldown_timer: Timer
var effects: Array
var available_charges: int
var actor: Node2D


func _init() -> void:
	actor = get_parent()
	available_charges = charges
	
	# Create the cooldown timer
	cooldown_timer = Timer.new()
	if cooldown_timer.connect( "timeout", self, "_on_cooldown_timer_timeout" ):
		print_debug( "Error connecting Timer" )
	cooldown_timer.set_one_shot( false )
	cooldown_timer.set_autostart( false )
	cooldown_timer.set_wait_time( cooldown )
	add_child( cooldown_timer )
	

func _ready():
	_init()


# Add an effect to the skill
# TODO: distinguish between different effects (when they go off)
func add_effect( _effect: Effect ) -> void:
	effects += [ _effect ]
	add_child( _effect )
	

# Play all my effects
func play_effects( mouse_posn: Vector2, target: Node2D = null ) -> void:
	for node in get_children():
		if (node is Effect):
			node.play( mouse_posn, target )
#	for effect in effects:
#		effect.play( mouse_posn, target )
	

# General check to see if the skill is on cool down, or if I am crowd controlled
func use( _mouse_posn: Vector2, target: Node2D = null ) -> int:
	if !available_charges:
		return SkillStatus.ON_COOLDOWN
	if actor.is_crowd_controlled() and !bypass_cc:
		return SkillStatus.CROWD_CONTROLLED
	
	if target and !is_in_range( target ):
		return SkillStatus.QUEUED
	
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
	available_charges -= 1
	return SkillStatus.USED
	

func is_in_range( _target: Node2D ) -> bool:
	if cast_range == 0.0:
		return true
	return ( _target.get_position() - actor.get_position() ).length() <= cast_range + _target.get_radius()
	

# Add a charge when my skill goes off cooldown
func _on_cooldown_timer_timeout() -> void:
	available_charges += 1
	if available_charges == charges:
		cooldown_timer.stop()
	

func is_on_cooldown() -> bool:
	return available_charges == 0
	

# Update my cooldown reduction. Called after equipping any item that gives cdr
func set_cooldown_reduction( cooldown_amount: float ) -> void:
	cooldown_timer.set_wait_time( cooldown * (1 - cooldown_amount) )
	
