extends Effect
class_name BuffEffect


export (float, 0, 10, 0.25) var duration := 1.0 setget set_duration, get_duration
export (int, 1, 50) var stacks := 1 setget set_stacks, get_stacks

# A dictionary that maps entities affected by this buff, to how many stacks they have
var stacks_reference: Dictionary


# Create the buff timer
func _create_buff_timer( _target: Entity ) -> Timer:
	var _buff_timer := Timer.new()
	_buff_timer.one_shot = true
	_buff_timer.autostart = true
	_buff_timer.wait_time = duration
	if _buff_timer.connect( "timeout", self, "_on_buff_timer_timeout", [ _buff_timer, _target ] ):
		print_debug( Utility.ERROR_SIGNAL )
	
	# Connect the target's destructor to this script. When they exit, we will remove them from our stacks_reference
	if !_target.is_connected( "tree_exiting", self, "_on_target_die" ):
		if _target.connect( "tree_exiting", self, "_on_target_die", [ _target ] ):
			print_debug( Utility.ERROR_SIGNAL )
	_target.add_child( _buff_timer )
	return _buff_timer
	

# Play the effect. Returns the buff timer attached to the target
func play( _actor: Entity, _mouse_posn: Vector2, _target: Entity ):
	if stacks_reference.has( _target ):
		if stacks_reference[ _target ] == stacks:
			return null
		stacks_reference[ _target ] += 1
	else:
		stacks_reference[ _target ] = 1
	return _create_buff_timer( _target )


# After the buff expires, undo the buff
func _on_buff_timer_timeout( _buff_timer: Timer, _target: Entity ) -> void:
	_buff_timer.queue_free()
	end( _target )
	

# End the buff. Generally it's the inverse of play()
func end( _target: Entity ) -> void:
	stacks_reference[ _target ] -= 1
	

# Remove the exiting target from the dictionary
func _on_target_die( _target: Entity ) -> void:
	if !stacks_reference.erase( _target ):
		pass
	


# Setgetters -------------------------------------- #
func get_duration() -> float:
	return duration
	

func set_duration( value: float ) -> void:
	duration = value
	

func set_stacks( value: int ) -> void:
	stacks = value
	

func get_stacks() -> int:
	return stacks
