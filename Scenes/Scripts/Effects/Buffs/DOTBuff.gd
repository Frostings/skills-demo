extends BuffEffect
class_name DOTBuff


export ( int, 1, 1000 ) var damage_per_tick := 1
export ( float, 0.01, 10 ) var time_between_ticks := 0.01


func play( _actor: Entity, _posn: Vector2, _target: Entity ) -> void:
	var buff_timer = .play( _actor, _posn, _target )
	if !buff_timer:
		return
	buff_timer.add_child( _create_dot_timer( _target ) )


func _create_dot_timer( _target: Entity ) -> Timer:
	var per_tick_timer := Timer.new()
	per_tick_timer.one_shot = false
	per_tick_timer.wait_time = time_between_ticks
	per_tick_timer.autostart = true
	if per_tick_timer.connect( "timeout", _target, "take_damage", [ damage_per_tick ] ):
		print_debug( Utility.ERROR_SIGNAL )
	return per_tick_timer
