extends Effect
class_name DashEffect


signal dash_started
signal dash_completed


export (float, 0, 500, 5) var dash_range := 100.0 setget set_dash_range, get_dash_range
export (float, 0, 5, 0.01) var speed: float
export (bool) var fixed_range := true setget set_fixed_range, get_fixed_range

var dash_tween: Tween
var _target: Entity
var mouse_posn: Vector2


func _ready():
	dash_tween = Tween.new()
	if dash_tween.connect( "tween_completed", self, "_on_dash_completed" ):
		print_debug( Utility.ERROR_SIGNAL )
	add_child( dash_tween )


# Play the effect
func play( _actor: Entity, _mouse_posn: Vector2, target: Entity ) -> void:
	mouse_posn = _mouse_posn
	var direction: Vector2
	var destination: Vector2
	var speed_scale: float = 1.0
	_target = target
	# We have a target queued. Dash to it.
	if target != _actor:
		direction = target.get_position() - _actor.get_position()
		#direction = direction.normalized()
		
		if fixed_range:
			destination = _actor.get_position() + direction.normalized() * dash_range
		else:
			if direction.length() < dash_range:
				speed_scale = direction.length()/dash_range
			# dash 1 length shy in direction of target such that we land on the same side as the dash
			destination = target.get_position() - direction.normalized()
	
	# Dash to the mouse position
	else:
		direction = mouse_posn - _actor.get_position()
		if !fixed_range and direction.length() <= dash_range:
			speed_scale = direction.length()/dash_range
			destination = _actor.position + direction
		else:
			direction = direction.normalized()
			destination = _actor.position + direction * dash_range

	if !dash_tween.interpolate_property( _actor, "position", _actor.get_position(), destination, speed * speed_scale,
			Tween.TRANS_LINEAR, Tween.EASE_OUT_IN, delay ):
		print_debug( Utility.ERROR_INTERPOLATE )
	
	if !dash_tween.start():
		print_debug( Utility.ERROR_TWEEN_START )

	emit_signal("dash_started")


# After dashing, snap out of colliders
func _on_dash_completed( _actor: KinematicBody2D, _key: NodePath ) -> void:
	var _collision: KinematicCollision2D = _actor.move_and_collide( Vector2(0,0) )
	emit_signal("dash_completed")
	# Play any effects in its children when finished
	for child in get_children():
		if child is Effect:
			child.play( _actor, mouse_posn, _target )



# Setgetters -------------------------------------- #
func set_dash_range( value: float ) -> void:
	dash_range = stepify( value, 1 )


func get_dash_range() -> float:
	return dash_range
	
	
func set_fixed_range( value: bool ) -> void:
	fixed_range = value
	

func get_fixed_range() -> bool:
	return fixed_range
