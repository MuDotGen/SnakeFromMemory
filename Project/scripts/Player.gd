extends Node

class_name Player

@export var snake_segment_scene: PackedScene
@export var snake_segments_node: Node2D

func _ready():
	if snake_segment_scene:
		var first_segment = snake_segment_scene.instantiate()
		snake_segments_node.add_child(first_segment) # Add the new instance to the container of snake segments
		print("Child count after adding:", snake_segments_node.get_child_count()) # This should be 1 more than before
	else:
		push_error("No snake_segment_scene assigned in the Player scene")
