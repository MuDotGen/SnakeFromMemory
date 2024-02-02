class_name Level
extends Node2D

@export var player_node: Node = null  # Initialize player_node to null

# Obstacles
@export var obstacle_scene: PackedScene = null
@export var obstacles_node: Node = null

# Foods
@export var food_scene: PackedScene = null
@export var foods_node: Node = null

const X_OPEN_RANGE: Vector2 = Vector2(1, GridUtility.NUM_COLUMNS - 1)
const Y_OPEN_RANGE: Vector2 = Vector2(1, GridUtility.NUM_ROWS - 2)

func _ready():
	reset_level()
	if not foods_node:
		foods_node = $Foods as Node2D  # Fallback if not set in the editor

func reset_level():
	# Reset the player
	print("Resetting Level")
	if obstacles_node:
		_setup_boundary()
	if player_node:
		player_node.reset()

func _setup_boundary():
	# Nested for loop to instantiating obstacles in rectangle border
	for x in range(0, GridUtility.NUM_COLUMNS):
		print("x: " + str(x))
		_instantiate_obstacle(Vector2(x, 0))  # Top boundary
		_instantiate_obstacle(Vector2(x, GridUtility.NUM_ROWS - 2))  # Bottom boundary
	
	for y in range(1, GridUtility.NUM_ROWS - 2):
		print("y: " + str(y))
		_instantiate_obstacle(Vector2(0, y))  # Left boundary
		_instantiate_obstacle(Vector2(GridUtility.NUM_COLUMNS - 1, y))  # Right boundary
	
func _instantiate_obstacle(obstacle_grid_position: Vector2):
	if obstacle_scene and obstacles_node:
		var obstacle_instance: Obstacle = obstacle_scene.instantiate()
		obstacles_node.add_child(obstacle_instance)
		obstacle_instance.grid_position = obstacle_grid_position
	else:
		push_error("Obstacle scene or obstacles node is not set in Level scene.")

func _instantiate_food(food_grid_position: Vector2):
	if food_scene and foods_node:
		var food_instance: Food = food_scene.instantiate()
		foods_node.add_child(food_instance)
		food_instance.grid_position = food_grid_position
	else:
		push_error("Food scene or foods node is not set in Level scene.")
