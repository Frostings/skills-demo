extends TargetQueue
class_name BasicAttack


export (bool) var melee = true setget , is_melee


func _ready() -> void:
	animation_delay = cooldown
	

# Setgetters -------------------------------------- #
func is_melee() -> bool:
	return melee
