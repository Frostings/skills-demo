extends Node2D

class_name Effect

const STEP = 0.001

export (int, "Dash", "Blink", "AOE", "Buff") var type: int
export (bool) var fixed_range: bool = true
export (float, 0, 5, 0.01) var delay: float = 0.0

var _actor: Node2D
var _target: Node2D

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
