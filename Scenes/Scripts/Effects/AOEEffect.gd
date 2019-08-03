extends Effect

class_name AOEEffect

export (float, 0, 500, 5) var aoe_radius: float = 100.0 setget set_aoe_radius, get_aoe_radius

onready var area: Area2D


# Play the effect
func play( _mouse_posn: Vector2, _target: Node2D = null ) -> void:
	pass
	

func set_aoe_radius( value: float ) -> void:
	aoe_radius = stepify( value, 0.01 )


func get_aoe_radius() -> float:
	return aoe_radius
