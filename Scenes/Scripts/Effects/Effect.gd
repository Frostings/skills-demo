extends Node2D
class_name Effect, "res://Assets/CustomIcons/Effect.png"


const STEP = 0.001

export (float, 0, 5, 0.01) var delay := 0.0 setget set_delay, get_delay

enum Type {
	DASH,
	BLINK,
	AOE,
	BUFF
}


#func _ready():
#	_actor = get_parent().get_parent()


func play( _actor: PhysicsBody2D, _mouse_posn: Vector2, _target: PhysicsBody2D = null ) -> void:
	pass



# Setgetters -------------------------------------- #
func get_delay() -> float:
	return delay


func set_delay( value: float ) -> void:
	delay = stepify( value, STEP )
