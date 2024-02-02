class_name Player
extends GridNode

# Snake Segments
@export var snake_segment_scene: PackedScene
@export var snake_segments_node: Node2D

# Player Direction
@export var current_direction: Vector2 = GridUtility.DIRECTIONS.DOWN

# Player MoveStateMachine
@export var move_state_machine: Node

#@onready var snake_segments: Array[Node] = snake_segments_node.get_children()

func _ready():
	if snake_segment_scene:
		var first_segment = snake_segment_scene.instantiate()
		first_segment.area_entered.connect(_on_snake_segment_collision)
		snake_segments_node.add_child(first_segment) # Add the new instance to the container of snake segments
		
		#snake_segments = snake_segments_node.get_children()
		#for segment in snake_segments:
			#print(segment.name)
	else:
		push_error("No snake_segment_scene assigned in the Player scene")
	
	_change_move_state("IdleMoveState")
	
func _change_move_state(state_name: StringName):
	if move_state_machine:
		move_state_machine.on_child_transitioned(state_name)
	else:
		push_error("No move_state_machine assigned in the Player scene")

func _on_snake_segment_collision(area: Area2D):
	# Let a manager know hit something and what it is
	if area.is_in_group("snakeSegment"):
		print("Hit Snake Segment: " + area.name)
		_change_move_state("PausedMoveState")
	elif area.is_in_group("obstacles"):
		print("Hit an Obstacle: " + area.name)
		area.queue_free()
		_change_move_state("PausedMoveState")
	elif area.is_in_group("foods"):
		print("Hit a Food")
		area.queue_free()
	else:
		print("Hit something")
