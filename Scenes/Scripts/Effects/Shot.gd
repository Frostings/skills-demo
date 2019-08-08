extends Sprite
class_name Shot

signal skill_shot_hit

var speed: float setget set_speed, get_speed
var radius: float setget set_radius, get_radius
var skill_shot_range: float
var fixed_range: bool

var actor: Entity setget set_actor, get_actor
	
var destination: Vector2
var tween: Tween

onready var area: Area2D = Area2D.new()
onready var collision_shape_2d: CollisionShape2D = CollisionShape2D.new()


func _ready() -> void:
	
	tween = Tween.new()
	if tween.connect( "tween_completed", self, "_on_skill_shot_reached" ):
		print_debug( Utility.ERROR_SIGNAL )
	add_child( tween )
	
	look_at( destination )
	
	# Create the collision bounds
	collision_shape_2d.shape = CircleShape2D.new()
	collision_shape_2d.shape.radius = radius
	area.add_child( collision_shape_2d )
	add_child(area)
	if area.connect( "body_entered", self, "_on_body_entered" ):
		print_debug( Utility.ERROR_SIGNAL )

	# Set the destination
	var direction: Vector2 = destination - position
	if !fixed_range and direction.length() <= skill_shot_range:
		destination = position + direction
	else:
		direction = direction.normalized()
		destination = position + direction * skill_shot_range
	
	# Create the tween
	if !tween.interpolate_property( self, "position", position, destination, speed,
			Tween.TRANS_LINEAR, Tween.EASE_OUT_IN ):
		print_debug( Utility.ERROR_INTERPOLATE )
	
	if !tween.start():
		print_debug( Utility.ERROR_TWEEN_START )


func _on_body_entered( _body: Entity ) -> void:
	if _body == actor: return
	emit_signal( "skill_shot_hit", get_parent(), actor, _body )

	hide()
	queue_free()
			

func _on_skill_shot_reached( _actor: Entity, _key: NodePath ) -> void:
	hide()
	queue_free()



# Setgetters -------------------------------------- #
func set_speed( value: float ) -> void:
	speed = stepify( value, 1 )
	

func get_speed() -> float:
	return speed
	
	
func set_radius( value: float ) -> void:
	radius = stepify( value, 1 )
	

func get_radius() -> float:
	return radius


func set_actor( value: Entity ) -> void:
	actor = value
	

func get_actor() -> Entity:
	return actor
