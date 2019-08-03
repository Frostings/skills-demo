extends Node2D

class_name Effect, "res://Assets/CustomIcons/Effect.png"

const STEP = 0.001

export (int, "Dash", "Blink", "AOE", "Buff") var type: int setget , get_type
export (bool) var fixed_range: bool = true setget set_fixed_range, get_fixed_range
export (float, 0, 5, 0.01) var delay: float = 0.0 setget set_delay, get_delay

var _actor: Node2D

enum Type {
	DASH,
	BLINK,
	AOE,
	BUFF
}


func _ready():
	_actor = get_parent().get_parent()


func play( _mouse_posn: Vector2, _target: Node2D = null ) -> void:
	pass
	

#func get_target() -> Node2D:
#	return target
	

func set_fixed_range( value: bool ) -> void:
	fixed_range = stepify( value, STEP )
	

func get_fixed_range() -> bool:
	return fixed_range


func get_type() -> int:
	return type


func get_delay() -> float:
	return delay


func set_delay( value: float ) -> void:
	delay = stepify( value, STEP )
