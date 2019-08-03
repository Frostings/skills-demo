extends Node2D
class_name Seeker

signal seeker_hit

var speed: float setget set_speed, get_speed
var radius: float = 0 setget set_radius, get_radius

var actor: PhysicsBody2D setget set_actor, get_actor
var target: PhysicsBody2D setget set_target, get_target


func _physics_process( _delta: float ) -> void:
	# Follow the target every frame
	position += ( target.position - position ).normalized() * speed * _delta
	look_at( target.position )
	if ( target.position - position ).length() <= target.radius + radius:
		emit_signal( "seeker_hit", target )
		hide()
		queue_free()


func set_target( value: PhysicsBody2D ) -> void:
	target = value


func get_target() -> PhysicsBody2D:
	return target
	

func set_speed( value: float ) -> void:
	speed = stepify( value, 1 )
	

func get_speed() -> float:
	return speed
	
	
func set_radius( value: float ) -> void:
	speed = stepify( value, 1 )
	

func get_radius() -> float:
	return speed


func set_actor( value: PhysicsBody2D ) -> void:
	actor = value
	

func get_actor() -> PhysicsBody2D:
	return actor
