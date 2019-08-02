extends Effect

class_name DashEffect

var dash_range: float
var speed: float
var delay: float

var dash_tween: Tween


func _init( _dash_range: float, _speed: float, _delay: float ).( Effect.Type.DASH ) -> void:
	dash_range = _dash_range
	speed = _speed
	delay = _delay
	
	dash_tween = Tween.new()
	if dash_tween.connect( "tween_completed", self, "_on_dash_completed" ):
		print_debug( "Error connecting Tween's signal" )
	add_child( dash_tween )


# Play the effect
func play( actor: KinematicBody2D, mouse_posn: Vector2, target: Node2D ) -> void:
	var velocity: Vector2
	if target:
		velocity = target.position - actor.position
	else:
		velocity = mouse_posn - actor.position
	velocity = velocity.normalized()
	
	if !dash_tween.interpolate_property( actor, "position", actor.position, actor.position + velocity * dash_range, speed,
			Tween.TRANS_LINEAR, Tween.EASE_OUT_IN, delay ):
		print_debug( "Error setting Tween's interpolate_property" )
	
	if !dash_tween.start():
		print_debug( "Error starting Tween" )


# After dashing, snap out of colliders
func _on_dash_completed( actor: KinematicBody2D, _key: NodePath ) -> void:
	var _collision: KinematicCollision2D = actor.move_and_collide( Vector2(0,0) )
