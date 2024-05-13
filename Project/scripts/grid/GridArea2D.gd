class_name GridArea2D
extends Area2D

@export var grid_position: Vector2i = Vector2i.ZERO:
	set(pos):
		grid_position = pos
		position = GridUtility.grid_to_world(grid_position)

func _ready() -> void:
	position = GridUtility.grid_to_world(grid_position)
