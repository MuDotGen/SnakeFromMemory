class_name Player
extends GridNode

# Snake Segments
@export var snake_segment_scene: PackedScene
@export var snake_segments_node: Node2D

# Player Direction
@export var current_direction: Vector2 = GridUtility.DIRECTIONS.DOWN

#@onready var snake_segments: Array[Node] = snake_segments_node.get_children()

func _ready():
	
	if snake_segment_scene:
		var first_segment = snake_segment_scene.instantiate()
		snake_segments_node.add_child(first_segment) # Add the new instance to the container of snake segments
		
		#snake_segments = snake_segments_node.get_children()
		#for segment in snake_segments:
			#print(segment.name)
	else:
		push_error("No snake_segment_scene assigned in the Player scene")
