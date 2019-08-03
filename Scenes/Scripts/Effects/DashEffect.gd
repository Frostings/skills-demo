extends Effect

class_name DashEffect

export (float, 0, 500, 5) var dash_range: float setget set_dash_range, get_dash_range
export (float, 0, 5, 0.01) var speed: float

var dash_tween: Tween


func _ready():
	dash_tween = Tween.new()
	if dash_tween.connect( "tween_completed", self, "_on_dash_completed" ):
		print_debug( "Error connecting Tween's signal" )
	add_child( dash_tween )


# Play the effect
func play( mouse_posn: Vector2, target: Node2D = null ) -> void:
	var direction: Vector2
	var destination: Vector2
	
	# We have a target queued. Dash to it.
	if target:
		direction = target.get_position() - _actor.get_position()
		direction = direction.normalized()
		
		if fixed_range:
			destination = _actor.get_position() + direction * dash_range
		else:
			# dash 1 length shy in direction of target such that we land on the same side as the dash
			destination = target.get_position() - direction
	
	# Dash to the mouse position
	else:
		direction = mouse_posn - _actor.get_position()
		if !fixed_range and direction.length() <= dash_range:
			destination = _actor.get_position() + direction
		else:
			direction = direction.normalized()
			destination = _actor.get_position() + direction * dash_range

	if !dash_tween.interpolate_property( _actor, "position", _actor.get_position(), destination, speed,
			Tween.TRANS_LINEAR, Tween.EASE_OUT_IN, delay ):
		print_debug( "Error setting Tween's interpolate_property" )
	
	if !dash_tween.start():
		print_debug( "Error starting Tween" )


# After dashing, snap out of colliders
func _on_dash_completed( _actor: KinematicBody2D, _key: NodePath ) -> void:
	var _collision: KinematicCollision2D = _actor.move_and_collide( Vector2(0,0) )
	

func set_dash_range( value: float ) -> void:
	dash_range = stepify( value, 5 )


func get_dash_range() -> float:
	return dash_range
	
	
