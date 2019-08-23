extends Area2D


var duration: float
var delay: float
var aoe_effect: Effect


func _ready() -> void:
	show()
	if connect( "body_entered", aoe_effect, "_on_body_entered" ):
		print_debug( Utility.ERROR_SIGNAL )
	if connect( "body_exited", aoe_effect, "_on_body_exited" ):
		print_debug( Utility.ERROR_SIGNAL )
	
	# Create the expire timer
	var _expire_timer := Timer.new()
	_expire_timer.name = "ExpireTimer"
	_expire_timer.one_shot = true
	_expire_timer.wait_time = duration
	_expire_timer.autostart = false
	if _expire_timer.connect( "timeout", self, "queue_free" ):
		print_debug( Utility.ERROR_SIGNAL )
	add_child( _expire_timer )
	
	# Create the delay timer
	var _delay_timer := Timer.new()
	_delay_timer.name = "DelayTimer"
	_delay_timer.one_shot = true
	_delay_timer.wait_time = delay
	_delay_timer.autostart = true
	if _delay_timer.connect( "timeout", self, "_on_delay_timer_timeout", [ _delay_timer, _expire_timer ] ):
		print_debug( Utility.ERROR_SIGNAL )
	add_child( _delay_timer )


func _on_delay_timer_timeout( _delay_timer: Timer, _expire_timer: Timer ) -> void:
	monitoring = true
	_expire_timer.start()
	_delay_timer.queue_free()
