extends Effect
class_name SkillShotEffect


export (float, 0, 500, 5) var skill_shot_range: float = 100 setget set_skill_shot_range, get_skill_shot_range
export (float, 0, 5, 0.01) var speed: float setget set_speed, get_speed
export (float, 0, 500, 1) var radius: float = 50 setget set_radius, get_radius
export (bool) var fixed_range: bool = true

export ( Texture ) var texture: Texture

var shot_script: Reference = preload("res://Scenes/Scripts/Effects/Shot.gd")


func play( _mouse_posn: Vector2, _target: PhysicsBody2D = null ) -> void:
	_create_shot( _mouse_posn, _target )
	

func _create_shot( _mouse_posn: Vector2, _target: PhysicsBody2D ) -> void:
	var shot: Sprite = Sprite.new()
	shot.set_script( shot_script )
	
	shot.actor = _actor
	shot.texture = texture
	shot.destination = _mouse_posn
	shot.position = global_position
	shot.speed = speed
	shot.radius = radius
	shot.skill_shot_range = skill_shot_range
	shot.fixed_range = fixed_range
	
	get_owner().add_child( shot )

	if shot.connect( "skill_shot_hit", self, "on_shot_hit" ):
		print_debug( Utility.ERROR_SIGNAL )
	

func on_shot_hit( _effect: Effect, _actor: PhysicsBody2D, target: PhysicsBody2D ) -> void:
	for child in get_children():
		if child is Effect:
			child.play( Vector2(), target )



# Setgetters ------------------------------ #
func set_radius( value: float ) -> void:
	radius = stepify( value, 1 )
	

func get_radius() -> float:
	return radius
	

func set_speed( value: float ) -> void:
	speed = stepify( value, 0.001 )
	
	
func get_speed() -> float:
	return speed


func set_skill_shot_range( value: float ) -> void:
	skill_shot_range = stepify( value, 1 )
	
	
func get_skill_shot_range() -> float:
	return skill_shot_range
	

