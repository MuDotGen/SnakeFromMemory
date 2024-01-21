extends Node

class_name GridUtility

const USE_TILE_CENTERS = true # If true, the world position will be in the center of the tiles

const WORLD_WIDTH = 512
const WORLD_HEIGHT = 288
const TILE_SIZE = 16
const TILE_OFFSET: int = TILE_SIZE / 2 if USE_TILE_CENTERS else 0
const NUM_COLUMNS: int = WORLD_WIDTH / TILE_SIZE
const NUM_ROWS: int = WORLD_HEIGHT / TILE_SIZE

# Given a grid position as a Vector2, return the equivalent world position
static func grid_to_world(position: Vector2) -> Vector2:
	if position:
		var world_position_x: int = clamp(position.x * TILE_SIZE + TILE_OFFSET, 0, WORLD_WIDTH - 1)
		var world_position_y: int = clamp(position.y * TILE_SIZE + TILE_OFFSET, 0, WORLD_HEIGHT - 1)
		return Vector2(world_position_x, world_position_y)
	else:
		return Vector2.ZERO
	
# 
static func world_to_grid(position: Vector2) -> Vector2:
	var grid_position_x: int = clamp((position.x - TILE_OFFSET) / TILE_SIZE, 0, NUM_COLUMNS - 1)
	var grid_position_y: int = clamp((position.y - TILE_OFFSET) / TILE_SIZE, 0, NUM_ROWS - 1)
	return Vector2(grid_position_x, grid_position_y)

#func _debug_grid_functions():
	#print("Testing grid_to_world and world_to_grid functions:")
	#print("Number of columns: " + str(NUM_COLUMNS) + ", Number of rows: " + str(NUM_ROWS))
	#
	#var test_grid_positions = [
		#Vector2(0, 0),  # Top-left corner
		#Vector2(NUM_COLUMNS - 1, NUM_ROWS - 1),  # Bottom-right corner
		#Vector2(NUM_COLUMNS / 2, NUM_ROWS / 2),  # Center
		#Vector2(-5, -5),  # Out-of-bounds negative
		#Vector2(NUM_COLUMNS + 5, NUM_ROWS + 5)  # Out-of-bounds positive
	#]
	#
	#for grid_position in test_grid_positions:
		#var world_position = grid_to_world(grid_position)
		#var back_to_grid_position = world_to_grid(world_position)
		#print("Grid Position: %s, World Position: %s, Back to Grid: %s" % [grid_position, world_position, back_to_grid_position])

