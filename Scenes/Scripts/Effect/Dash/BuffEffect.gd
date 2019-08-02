extends Effect

class_name BuffEffect

var target: Node2D
var _buff_timer: Timer


func _init( _target:Node2D, duration: float ).( Effect.Type.BUFF ) -> void:
	target = _target
	_buff_timer = Timer.new()
	_buff_timer.set_one_shot( true )
	_buff_timer.set_autostart( false )
	_buff_timer.set_wait_time( duration )
	if _buff_timer.connect("timeout", self, "_on_buff_timer_timeout"):
		print_debug("Buff timer already connected")
	add_child( _buff_timer )


# Play the effect
func play( _actor: KinematicBody2D = null, _mouse_posn: Vector2 = Vector2(), _target: Node2D = null ) -> void:
	_buff_timer.start()


func get_target() -> Node2D:
	return target
	

# After the buff expires, undo the buff
func _on_buff_timer_timeout() -> void:
	end()


# End the buff. Generally it's the inverse of play()
func end() -> void:
	pass
