extends KinematicBody2D

signal enemy_hovered
signal enemy_unhovered

export (int, 0, 100, 5) var radius: int = 35 setget , get_radius


func _init() -> void:
	pass


func _ready() -> void:
	$CollisionShape2D.get_shape().set_radius( radius )


func _physics_process( _delta: float ) -> void:
	# Test the collision so that the Enemy doesn't get pushed by the player
	var collision: KinematicCollision2D = move_and_collide(Vector2(0,0), true, true, true)
	if collision:
		# collision.collider
		pass


func get_radius() -> int:
	return radius
	

func _on_mouse_entered() -> void:
	emit_signal("enemy_hovered", self)


func _on_mouse_exited() -> void:
	emit_signal("enemy_unhovered", self)
