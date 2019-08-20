# AOE Effect creates a zone that reports bodies in that zone. It must have an Area2D as a child
extends Effect
class_name AOEEffect


export (float, 0.01, 5, 0.01) var duration := 1.0
export (int, 0, 1000) var fixed_range := 0
export (int, "Ground", "Actor", "Target") var attach_to := 0
onready var area: Area2D
onready var bodies: Array = [] setget , get_bodies

var actor: Entity


func _ready() -> void:
	# Find the Area2D node in our children
	for child in get_children():
		if child is Area2D:
			area = child
			break
	if area == null:
		print_debug( Utility.ERROR_NO_NODE )
	area.hide()
	area.monitoring = false
	pass

	
# Play the effect
func play( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> void:
	actor = _actor
	
	# Create the area
	var _area: Area2D = area.duplicate()
	_area.show()
	if _area.connect( "body_entered", self, "_on_body_entered" ):
		print_debug( Utility.ERROR_SIGNAL )
	if _area.connect( "body_exited", self, "_on_body_exited" ):
		print_debug( Utility.ERROR_SIGNAL )
	
	match attach_to:
		0: # Ground
			_area.position = _mouse_posn
			get_owner().call_deferred( "add_child", _area )
		1: # Actor
			_area.position = ( _mouse_posn - _actor.position ).normalized() * fixed_range
			_actor.add_child( _area )
		2: # Target
			_area.position = Vector2()
			_target.add_child( _area )
	
	# Create the expire timer
	var _expire_timer := Timer.new()
	_expire_timer.name = "ExpireTimer"
	_expire_timer.one_shot = true
	_expire_timer.wait_time = duration
	_expire_timer.autostart = false
	if _expire_timer.connect( "timeout", self, "_on_expire_timer_timeout", [_area] ):
		print_debug( Utility.ERROR_SIGNAL )
	_area.add_child( _expire_timer )
	
	# Create the delay timer
	var _delay_timer := Timer.new()
	_delay_timer.name = "DelayTimer"
	_delay_timer.one_shot = true
	_delay_timer.wait_time = delay
	_delay_timer.autostart = true
	if _delay_timer.connect( "timeout", self, "_on_delay_timer_timeout", [ _area, _delay_timer, _expire_timer ] ):
		print_debug( Utility.ERROR_SIGNAL )
	_area.add_child( _delay_timer )


func _on_expire_timer_timeout( _area: Area2D ) -> void:
	_area.monitoring = false
	_area.queue_free()


func get_bodies() -> Array:
	return bodies


# TODO: Perhaps move this somewhere else
class SortByName:
	static func sort( a: PhysicsBody2D, b: PhysicsBody2D ) -> bool:
		if a.name < b.name:
			return true
		return false


func _on_body_entered( body: PhysicsBody2D ) -> void:
	if body == actor:
		return
	var i: int = bodies.bsearch_custom( body, SortByName, "sort" )
	bodies.insert( i, body )
	if body is Entity:
		for child in get_children():
			if child is Effect:
				child.play( actor, Vector2(), body )


func _on_body_exited( body: PhysicsBody2D ) -> void:
	if body == actor:
		return
	var i: int = bodies.bsearch_custom( body, SortByName, "sort" )
	bodies.remove( i )


func _on_delay_timer_timeout( _area: Area2D, _delay_timer: Timer, _expire_timer: Timer ) -> void:
	_area.monitoring = true
	_expire_timer.start()
	_delay_timer.queue_free()
