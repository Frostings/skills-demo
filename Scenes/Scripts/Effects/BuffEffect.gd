extends Effect
class_name BuffEffect


export (float, 0, 5, 0.25) var _duration := 1.0 setget set_duration, get_duration

var _buff_timer: Timer


func _ready():
	# Create the buff timer
	_buff_timer = Timer.new()
	_buff_timer.one_shot = true
	_buff_timer.autostart = false
	_buff_timer.wait_time = _duration
	if _buff_timer.connect("timeout", self, "_on_buff_timer_timeout"):
		print_debug( Utility.ERROR_SIGNAL )
	add_child( _buff_timer )


# Play the effect
func play( _actor: PhysicsBody2D = null, _mouse_posn: Vector2 = Vector2(), _target: PhysicsBody2D = null ) -> void:
	_buff_timer.start()


# After the buff expires, undo the buff
func _on_buff_timer_timeout() -> void:
	end()
	

# End the buff. Generally it's the inverse of play()
func end() -> void:
	pass
	


# Setgetters -------------------------------------- #
func get_duration() -> float:
	return _duration
	

func set_duration( value: float ) -> void:
	_duration = value
	if _buff_timer:
		_buff_timer.set_wait_time( _duration )
	
