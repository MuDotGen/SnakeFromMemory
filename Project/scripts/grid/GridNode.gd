class_name GridNode
extends Node2D

@export var grid_position: Vector2 = Vector2.ZERO:
	set(pos):
		# First set the new grid position as a 2D coordinate
		grid_position = pos
		# Set the Node's actual position to the equivalent world position
		position = GridUtility.grid_to_world(grid_position)

func _ready():
	position = GridUtility.grid_to_world(grid_position)
