# Skill Ground Immediate is a skill you can press with your mouse anywhere on the screen
# And it will automatically attempt to cast

extends Skill

class_name GroundImmediate


func _init():
	pass


func use( actor: KinematicBody2D, mouse_posn: Vector2, _acting_on: Node2D = null ) -> int:
	return .use( actor, mouse_posn, _acting_on )

