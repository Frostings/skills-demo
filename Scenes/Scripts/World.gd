extends Node2D


func _ready() -> void:
	# TODO: connect each Enemy instances' signals to pass down to the Player
	if $Enemy.connect("enemy_hovered", $Player, "_on_enemy_hovered"):
		print_debug("Error connecting signal")
	if $Enemy.connect("enemy_unhovered", $Player, "_on_enemy_unhovered"):
		print_debug("Error connecting signal")

