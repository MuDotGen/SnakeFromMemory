class_name GridArea2D
extends Area2D

@export var grid_position: Vector2 = Vector2.ZERO:
	set(pos):
		grid_position = pos
		position = GridUtility.grid_to_world(grid_position)

func _ready():
	position = GridUtility.grid_to_world(grid_position)
