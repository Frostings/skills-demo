extends Effect

class_name BuffEffect

export (float, 0, 5, 0.25) var _duration: float = 1.0

var _target: Node2D
var _buff_timer: Timer

	
func _ready():
	# Create the buff timer
	_buff_timer = Timer.new()
	_buff_timer.set_one_shot( true )
	_buff_timer.set_autostart( false )
	if _buff_timer.connect("timeout", self, "_on_buff_timer_timeout"):
		print_debug("Buff timer already connected")
	add_child( _buff_timer )

# Play the effect
func play( _mouse_posn: Vector2 = Vector2(), _target: Node2D = null ) -> void:
	_buff_timer.start()
	

func get_target() -> Node2D:
	return _target
	

# After the buff expires, undo the buff
func _on_buff_timer_timeout() -> void:
	end()
	

# End the buff. Generally it's the inverse of play()
func end() -> void:
	pass
	

func get_duration() -> float:
	return _duration
	

func set_duration( value: float ) -> void:
	_duration = value
	_buff_timer.set_wait_time( _duration )
	
