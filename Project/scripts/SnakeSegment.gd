class_name SnakeSegment
extends GridArea2D


var tail_segment: SnakeSegment
var last_grid_position: Vector2i
var current_direction: Vector2i
var last_direction: Vector2i

func _ready() -> void:
	print("New Snake Segment Initialized")

func initialize_segment(pos: Vector2i, dir: Vector2i) -> void:
	grid_position = pos
	current_direction = dir

func add_segment(new_segment: SnakeSegment) -> void:
	# Recursively check if this is the last segment in the snake
	if tail_segment:
		# If it has a tail, have the next segment attempt to add it
		tail_segment.add_segment(new_segment)
	else:
		# If it has no tail, it's the last segment, so add the new segment
		if last_grid_position == Vector2i(0,0):
			pass
		new_segment.initialize_segment(last_grid_position, last_direction)
		tail_segment = new_segment

func move(new_grid_position: Vector2i, new_direction: Vector2i) -> void:
	# Recursively move each tail to the position of the segment in front of it
	
	# Store the current_grid_position as the last one before updating position
	last_grid_position = grid_position
	last_direction = current_direction
	
	# Move the the current segment
	grid_position = new_grid_position
	current_direction = new_direction

	if tail_segment:
		# If it has a tail, get current position and pass it on before moving
		tail_segment.move(last_grid_position, last_direction)
