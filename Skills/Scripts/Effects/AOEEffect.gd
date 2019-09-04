# AOE Effect creates a zone that reports bodies in that zone. It must have an Area2D as a child
extends Effect
class_name AOEEffect


export (float, 0.01, 5, 0.01) var duration := 1.0
export (int, 0, 1000) var fixed_range := 0
export (int, "Ground", "Actor", "Target") var attach_to := 0
export (Texture) var indicator: Texture
export (Texture) var aoe_texture: Texture
export (bool) var look_at := false

onready var area: Area2D
onready var bodies: Array = [] setget , get_bodies

var actor: Entity

var _aoe_script: Reference = preload("res://Skills/Scripts/Effects/AOE.gd")


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
	_area.set_script( _aoe_script )
	_area.duration = duration
	_area.delay = delay
	_area.aoe_effect = self
	_area.aoe_texture = aoe_texture
	if look_at:
		_area.look_at = true
		_area.look_at_position = _mouse_posn + _mouse_posn - _actor.position
	# Create the indicator
	var _indicator_sprite := Sprite.new()
	_indicator_sprite.texture = indicator
	_indicator_sprite.z_index = -1
	
	# Create the indicator's tween
	var _indicator_tween := Tween.new()
	if !_indicator_tween.interpolate_property( _indicator_sprite, "modulate", Color( 1,1,1,0.1 ), Color( 1,1,1,0.5 ), delay,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT ):
		print_debug( Utility.ERROR_INTERPOLATE )
	if !_indicator_tween.start():
		print_debug( Utility.ERROR_TWEEN_START )
	_indicator_sprite.add_child( _indicator_tween )
	_area.add_child( _indicator_sprite )
	
	
	match attach_to:
		0: # Ground
			_area.global_position = _mouse_posn
			get_node( "/root" ).add_child( _area )
		1: # Actor
			_area.position = ( _mouse_posn - _actor.position ).normalized() * fixed_range
			_actor.add_child( _area )
		2: # Target
			_area.position = Vector2()
			_target.add_child( _area )


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
