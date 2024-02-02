class_name Player
extends Node

# Snake Segments
@export var snake_segment_scene: PackedScene
@export var snake_segments_node: Node2D
var head_snake_segment: SnakeSegment

# Player Direction
@export var current_direction: Vector2 = GridUtility.DIRECTIONS.DOWN

# Player Speedup Factor
@export var movement_interval: float = 0.5 # In seconds
@export var speedup_factor: float = 1.1 # Factor 1 means no speedup, 1.1 is 10% speed up per food

# Player MoveStateMachine
@export var move_state_machine: Node
	
func move(new_position: Vector2):
	head_snake_segment.move(new_position, current_direction)
	
func get_snake_grid_position() -> Vector2:
	if head_snake_segment:
		return head_snake_segment.grid_position
	else:
		push_error("head_snake_segment not ready in the Player scene")
		return Vector2.ZERO

func reset():
	print("Calling Reset")
	if snake_segment_scene:
		head_snake_segment = _add_snake_segment() # Keep a reference to the first segment added
		var player_starting_position = Vector2(GridUtility.NUM_COLUMNS / 2, GridUtility.NUM_ROWS / 2)
		print(player_starting_position)
		head_snake_segment.initialize_segment(player_starting_position, GridUtility.DIRECTIONS.DOWN)
	else:
		push_error("No snake_segment_scene assigned in the Player scene")
	
	_change_move_state("IdleMoveState")
	
func _change_move_state(state_name: StringName):
	if move_state_machine:
		move_state_machine.on_child_transitioned(state_name)
	else:
		push_error("No move_state_machine assigned in the Player scene")

func _add_snake_segment() -> SnakeSegment:
	# Create a new Snake Segment
	var new_segment = snake_segment_scene.instantiate()
	snake_segments_node.add_child(new_segment) # Add the new instance to the tree
	
	if head_snake_segment:
		# If the head is set, add it to the tail
		head_snake_segment.add_segment(new_segment)
	else:
		# If it's the first segment, set the new segment as the head
		head_snake_segment = new_segment
	
	# Listen in on each snake segment if something collides with it
	new_segment.area_entered.connect(_on_snake_segment_collision)
	
	# Optionally return a reference to the new segment
	return new_segment

func _on_snake_segment_collision(area: Area2D):
	# Let a manager know hit something and what it is
	if area.is_in_group("snakeSegments"):
		print("Hit Snake Segment: " + area.name)
		area.queue_free()
		_change_move_state("PausedMoveState")
	elif area.is_in_group("obstacles"):
		print("Hit an Obstacle: " + area.name)
		area.queue_free()
		_change_move_state("PausedMoveState")
	elif area.is_in_group("foods"):
		print("Hit a Food: " + area.name)
		area.queue_free()
		_add_snake_segment()
	else:
		print("Hit something: " + area.name)
