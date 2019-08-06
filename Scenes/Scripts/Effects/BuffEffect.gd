extends Effect
class_name BuffEffect


export (float, 0, 5, 0.25) var duration := 1.0 setget set_duration, get_duration
export (int, 1, 50) var stacks := 1 setget set_stacks, get_stacks

onready var _stacks_available := stacks

var _buff_timer: Timer


func _ready():
	# Create the buff timer
	_buff_timer = Timer.new()
	_buff_timer.one_shot = true
	_buff_timer.autostart = false
	_buff_timer.wait_time = duration
	if _buff_timer.connect("timeout", self, "_on_buff_timer_timeout"):
		print_debug( Utility.ERROR_SIGNAL )
	add_child( _buff_timer )


# Play the effect
func play( _actor: PhysicsBody2D = null, _mouse_posn: Vector2 = Vector2(), _target: PhysicsBody2D = null ):
	if !_stacks_available:
		return false
	_stacks_available -= 1
	_buff_timer.start()
	return true


# After the buff expires, undo the buff
func _on_buff_timer_timeout() -> void:
	end()
	

# End the buff. Generally it's the inverse of play()
func end() -> void:
	_stacks_available += 1
	


# Setgetters -------------------------------------- #
func get_duration() -> float:
	return duration
	

func set_duration( value: float ) -> void:
	duration = value
	if _buff_timer:
		_buff_timer.set_wait_time( duration )
	

func set_stacks( value: int ) -> void:
	stacks = value
	

func get_stacks() -> int:
	return stacks
