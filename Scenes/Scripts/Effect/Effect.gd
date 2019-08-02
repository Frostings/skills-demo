extends Node2D

class_name Effect

export (int, "Dash", "Blink", "AOE", "Buff") var type: int

var actor: Node2D

enum Type {
	DASH,
	BLINK,
	AOE,
	BUFF
}


func _init( _actor: Node2D, _type: int ) -> void:
	actor = _actor
	type = _type
	

func play( _mouse_posn: Vector2, _acting_on: Node2D ) -> void:
	pass
