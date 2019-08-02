# GroundImmediate is a skill that will cast irrespective of the mouse position.

extends Skill

class_name GroundImmediate


func _init( _actor:Node2D ).( _actor ) -> void:
	pass


func use( mouse_posn: Vector2, _acting_on: Node2D = null ) -> int:
	return .use( mouse_posn, _acting_on )

