# SeekingEffect must have a target. It will follow the target and signal when it reaches it

extends Effect
class_name SeekingEffect

export (float, 5, 5000, 5) var speed: float setget set_speed, get_speed
export (float, 0, 500, 1) var radius: float = 0 setget set_radius, get_radius
export ( Texture ) var texture: Texture

var seeker_script: Reference = preload("res://Scenes/Scripts/Effects/Seeker.gd")


# Play the effect
func play( _mouse_posn: Vector2, _target: PhysicsBody2D = null ) -> void:
	_create_seeker( _target )
	

func _create_seeker( _target: PhysicsBody2D ) -> void:
	var seeker: Sprite = Sprite.new()
	seeker.set_script( seeker_script )
	seeker.actor = _actor
	seeker.texture = texture
	seeker.target = _target
	seeker.position = global_position
	seeker.speed = speed
	if seeker.connect( "seeker_hit", self, "on_seeker_hit" ):
		print_debug( Utility.ERROR_SIGNAL )
	get_owner().add_child( seeker )
	
	
func on_seeker_hit( target: PhysicsBody2D ) -> void:
	for child in get_children():
		if child is Effect:
			child.play( Vector2(), target )
	

func set_radius( value: float ) -> void:
	radius = stepify( value, 1 )
	

func get_radius() -> float:
	return radius
	

func set_speed( value: float ) -> void:
	speed = stepify( value, 1 )
	
	
func get_speed() -> float:
	return speed

