extends Node2D
class_name Effect, "res://Skills/Assets/CustomIcons/Effect.png"


const STEP = 0.001

export (float, 0.01, 5, 0.01) var delay := 0.01 setget set_delay, get_delay

enum Type {
	DASH,
	BLINK,
	AOE,
	BUFF
}


func play( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> void:
	pass



# Setgetters -------------------------------------- #
func get_delay() -> float:
	return delay


func set_delay( value: float ) -> void:
	delay = stepify( value, STEP )
