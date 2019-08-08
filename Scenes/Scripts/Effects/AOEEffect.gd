# AOE Effect creates a zone that reports bodies in that zone. It must have an Area2D as a child
extends Effect
class_name AOEEffect


export (float, 0, 5, 0.1) var duration := 1

onready var area: Area2D
onready var bodies: Array = [] setget , get_bodies

var _expire_timer: Timer
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
	if area.connect( "body_entered", self, "_on_body_entered" ):
		print_debug( Utility.ERROR_SIGNAL )
	if area.connect( "body_exited", self, "_on_body_exited" ):
		print_debug( Utility.ERROR_SIGNAL )

	# Create the expire timer
	_expire_timer = Timer.new()
	_expire_timer.name = "ExpireTimer"
	_expire_timer.one_shot = true
	_expire_timer.autostart = false
	_expire_timer.wait_time = duration
	if _expire_timer.connect( "timeout", self, "_on_expire_timer_timeout" ):
		print_debug( Utility.ERROR_SIGNAL )
	add_child(_expire_timer)
	
	
# Play the effect
func play( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> void:
	actor = _actor
	area.monitoring = true
	_expire_timer.start()
	

func _on_expire_timer_timeout() -> void:
	area.monitoring = false


func get_bodies() -> Array:
	return bodies


# TODO: Perhaps move this somewhere else
class SortByName:
	static func sort( a: Entity, b: Entity ) -> bool:
		if a.name < b.name:
			return true
		return false


func _on_body_entered( body: Entity ) -> void:
	if body == actor:
		return
	var i: int = bodies.bsearch_custom( body, SortByName, "sort" )
	bodies.insert( i, body )


func _on_body_exited( body: Entity ) -> void:
	if body == actor:
		return
	var i: int = bodies.bsearch_custom( body, SortByName, "sort" )
	bodies.remove( i )

