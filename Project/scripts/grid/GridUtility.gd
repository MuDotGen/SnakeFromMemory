class_name GridUtility
extends Node

const USE_TILE_CENTERS = true # If true, the world position will be in the center of the tiles

const WORLD_WIDTH: int = 512
const WORLD_HEIGHT: int = 288
const TILE_SIZE: int = 16
const TILE_OFFSET: int = int(float(TILE_SIZE) / 2) if USE_TILE_CENTERS else 0
const NUM_COLUMNS: int = int(float(WORLD_WIDTH) / float(TILE_SIZE))
const NUM_ROWS: int = int(float(WORLD_HEIGHT) / float(TILE_SIZE))
const DIRECTIONS: Dictionary = { "UP": Vector2i(0, -1), "DOWN": Vector2i(0, 1), "LEFT": Vector2i(-1, 0), "RIGHT": Vector2i(1, 0) }

# Given a grid position as a Vector2i, return the equivalent world position
static func grid_to_world(position: Vector2i) -> Vector2i:
	if position != null:
		var world_position_x: int = clamp(position.x * TILE_SIZE + TILE_OFFSET, 0, WORLD_WIDTH - 1)
		var world_position_y: int = clamp(position.y * TILE_SIZE + TILE_OFFSET, 0, WORLD_HEIGHT - 1)
		return Vector2i(world_position_x, world_position_y)
	else:
		return Vector2i.ZERO
	
# 
static func world_to_grid(position: Vector2i) -> Vector2i:
	var grid_position_x: int = clamp(int(float(position.x - TILE_OFFSET) / float(TILE_SIZE)), 0, NUM_COLUMNS - 1)
	var grid_position_y: int = clamp(int(float(position.y - TILE_OFFSET) / float(TILE_SIZE)), 0, NUM_ROWS - 1)
	return Vector2i(grid_position_x, grid_position_y)

#func _debug_grid_functions():
	#print("Testing grid_to_world and world_to_grid functions:")
	#print("Number of columns: " + str(NUM_COLUMNS) + ", Number of rows: " + str(NUM_ROWS))
	#
	#var test_grid_positions = [
		#Vector2i(0, 0),  # Top-left corner
		#Vector2i(NUM_COLUMNS - 1, NUM_ROWS - 1),  # Bottom-right corner
		#Vector2i(NUM_COLUMNS / 2, NUM_ROWS / 2),  # Center
		#Vector2i(-5, -5),  # Out-of-bounds negative
		#Vector2i(NUM_COLUMNS + 5, NUM_ROWS + 5)  # Out-of-bounds positive
	#]
	#
	#for grid_position in test_grid_positions:
		#var world_position = grid_to_world(grid_position)
		#var back_to_grid_position = world_to_grid(world_position)
		#print("Grid Position: %s, World Position: %s, Back to Grid: %s" % [grid_position, world_position, back_to_grid_position])

