extends Node2D

class_name Effect

export (int, "Dash", "Blink", "AOE", "Buff") var type: int

enum Type {
	DASH,
	BLINK,
	AOE,
	BUFF
}


func _init( _type: int ) -> void:
	self.type = _type


func play( _actor: KinematicBody2D, _mouse_posn: Vector2, _acting_on: Node2D ) -> void:
	pass
