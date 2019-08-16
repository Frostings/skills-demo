# AOE Effect creates a zone that reports bodies in that zone. It must have an Area2D as a child
extends Effect
class_name AOEEffect


export (float, 0, 5, 0.1) var duration := 1.0
export (int, 0, 1000) var fixed_range := 0

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
	
	area.monitoring = false
	pass

	
# Play the effect
func play( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> void:
	var posn := _mouse_posn
	if _target and _target != _actor:
		posn = _target.position
	elif fixed_range:
		posn = _actor.global_position + ( _mouse_posn - _actor.global_position ).normalized() * fixed_range
	actor = _actor
	
	# Create the area
	var _area := area.duplicate()
	_area.position = posn
	_area.monitoring = true
	_area.show()
	if _area.connect( "body_entered", self, "_on_body_entered" ):
		print_debug( Utility.ERROR_SIGNAL )
	if _area.connect( "body_exited", self, "_on_body_exited" ):
		print_debug( Utility.ERROR_SIGNAL )
	get_owner().add_child( _area )
	
	# Create the expire timer
	var _expire_timer := Timer.new()
	_expire_timer.name = "ExpireTimer"
	_expire_timer.one_shot = true
	_expire_timer.wait_time = duration
	
	if _expire_timer.connect( "timeout", self, "_on_expire_timer_timeout", [_area] ):
		print_debug( Utility.ERROR_SIGNAL )
	_area.add_child( _expire_timer )
	_expire_timer.start()
	

func _on_expire_timer_timeout( _area: Area2D ) -> void:
	_area.monitoring = false
	_area.hide()
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
