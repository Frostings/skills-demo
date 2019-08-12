extends Effect
class_name SkillShotEffect


export (float, 0, 500, 5) var skill_shot_range := 100.0 setget set_skill_shot_range, get_skill_shot_range
export (float, 0, 5, 0.01) var speed := 0.1 setget set_speed, get_speed
export (float, 0, 500, 1) var radius := 50.0 setget set_radius, get_radius
export (int, -1, 10) var num_targets := 1 setget set_num_targets, get_num_targets
export (bool) var fixed_range := true


export ( Texture ) var texture: Texture

var shot_script: Reference = preload("res://Skills/Scripts/Effects/Shot.gd")


func play( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> void:
	_create_shot( _actor, _mouse_posn, _target )
	

func _create_shot( _actor: Entity, _mouse_posn: Vector2, _target: Entity ) -> void:
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
	shot.num_targets = num_targets
	get_owner().add_child( shot )

	if shot.connect( "skill_shot_hit", self, "on_shot_hit" ):
		print_debug( Utility.ERROR_SIGNAL )
	

func on_shot_hit( _effect: Effect, _actor: Entity, posn: Vector2, target: Entity ) -> void:
	for child in get_children():
		if child is Effect:
			child.play( _actor, posn, target )



# Setgetters -------------------------------------- #
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
	

func set_num_targets( value: int ) -> void:
	num_targets = value


func get_num_targets() -> int:
	return num_targets
