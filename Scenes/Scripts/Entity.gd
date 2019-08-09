extends KinematicBody2D
class_name Entity


func die() -> void:
	hide()
	queue_free()
	

# STATS
#######################################################################


# RADIUS
#######################################################################
export (int, 0, 100, 5) var radius: int = 35 setget , get_radius


func get_radius() -> int:
	return radius
	

# SPEED
#######################################################################
export (int, 0, 1000, 5) var base_speed := 200

var final_speed: int
var scaling_speed := 1.0
var flat_speed := 0


func add_speed( _flat_speed: int, _scaling_speed: float ) -> void:
	scaling_speed = stepify( scaling_speed * _scaling_speed, Utility.FLOAT_STEP )
	flat_speed += flat_speed
	update_speed()


func remove_speed( _flat_speed: int, _scaling_speed: float ) -> void:
	scaling_speed = stepify( scaling_speed / _scaling_speed, Utility.FLOAT_STEP )
	flat_speed -= flat_speed
	update_speed()


func update_speed() -> void:
	final_speed = int( stepify( base_speed * scaling_speed + flat_speed, 1 ) )


func _ready() -> void:
	update_speed()
	$CollisionShape2D.get_shape().set_radius( radius )


# HEALTH
#######################################################################

export (int, 1, 1000, 1) var max_health := 10
var current_health := max_health


func add_health( value: int ) -> void:
	current_health = int( min( max_health, current_health + value ) )


func remove_health( value: int ) -> void:
	current_health = int( max( 0, current_health - value ) )
	if current_health == 0:
		die()


# CRIT CHANCE
#######################################################################
export (int, 0, 100, 1) var crit_chance := 5


func add_crit( _crit_chance: int ) -> void:
	crit_chance = int( min( 100, crit_chance + _crit_chance ) )


func remove_crit( _crit_chance: int ) -> void:
	crit_chance = int( max( 0, crit_chance - _crit_chance ) )


# SHIELD
#######################################################################
var shield_amount: int


func add_shield( _amount: int ) -> void:
	shield_amount += _amount

	
func remove_shield( _amount: int ) -> void:
	shield_amount = int ( max( 0, shield_amount - _amount ) )

	
# ATTACK SPEED
#######################################################################
export ( float, 0.5, 2, 0.001 ) var attack_speed := 0.25


func add_attack_speed( value: float ) -> void:
	attack_speed = min( 2, attack_speed * value )


func remove_attack_speed( value: float ) -> void:
	attack_speed = max( 0.5, attack_speed / value )


# CROWD CONTROL
#######################################################################

# ROOT
#######################################################################
var rooted := 0


func set_rooted( value: bool ) -> void:
	rooted += 1 if value else -1
	

# STUN
#######################################################################
var stunned := 0


func set_stunned( value: bool ) -> void:
	stunned += 1 if value else -1


# SILENCE
#######################################################################
var silenced := 0


func set_silence( value: bool ) -> void:
	silenced += 1 if value else -1
