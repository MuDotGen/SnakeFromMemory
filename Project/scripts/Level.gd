class_name Level
extends Node2D

@export var player_node: Player = null  # Initialize player_node to null

# Obstacles
@export var obstacle_scene: PackedScene = null
@export var obstacles_node: Node = null

# Foods
@export var food_scene: PackedScene = null
@export var foods_node: Node = null

const X_OPEN_RANGE: Vector2i = Vector2i(1, GridUtility.NUM_COLUMNS - 2)
const Y_OPEN_RANGE: Vector2i = Vector2i(1, GridUtility.NUM_ROWS - 3)

var food_spawn_timer: Timer

func _ready() -> void:
	food_spawn_timer = Timer.new()
	add_child(food_spawn_timer)
	food_spawn_timer.one_shot = true
	food_spawn_timer.autostart = false
	
	reset_level()
	if not foods_node:
		foods_node = $Foods as Node2D  # Fallback if not set in the editor
	if not obstacles_node:
		obstacles_node = $Obstacles as Node2D  # Fallback if not set in the editor
	if not player_node:
		player_node = $Player as Player  # Fallback if not set in the editor

func reset_level() -> void:
	# Reset the player
	print("Resetting Level")
	if obstacles_node:
		_setup_boundary()
		
	if player_node:
		player_node.reset()
		player_node.food_eaten.connect(_on_food_eaten)

	if foods_node:
		_spawn_food_random_position()

func _setup_boundary() -> void:
	# Nested for loop to instantiating obstacles in rectangle border
	for x in range(0, GridUtility.NUM_COLUMNS):
		_instantiate_obstacle(Vector2i(x, 0))  # Top boundary
		_instantiate_obstacle(Vector2i(x, GridUtility.NUM_ROWS - 2))  # Bottom boundary
	
	for y in range(1, GridUtility.NUM_ROWS - 2):
		_instantiate_obstacle(Vector2i(0, y))  # Left boundary
		_instantiate_obstacle(Vector2i(GridUtility.NUM_COLUMNS - 1, y))  # Right boundary
	
func _instantiate_obstacle(obstacle_grid_position: Vector2i) -> void:
	if obstacle_scene and obstacles_node:
		var obstacle_instance: Obstacle = obstacle_scene.instantiate()
		obstacles_node.add_child(obstacle_instance)
		obstacle_instance.grid_position = obstacle_grid_position
	else:
		push_error("Obstacle scene or obstacles node is not set in Level scene.")

func _get_random_position() -> Vector2i:
	var x: int = randi_range(X_OPEN_RANGE.x, X_OPEN_RANGE.y)
	var y: int = randi_range(Y_OPEN_RANGE.x, Y_OPEN_RANGE.y)
	return Vector2i(x, y)

func _instantiate_food(food_grid_position: Vector2i) -> void:
	if food_scene and foods_node:
		var food_instance: Food = food_scene.instantiate()
		foods_node.add_child(food_instance)
		food_instance.grid_position = food_grid_position
	else:
		push_error("Food scene or foods node is not set in Level scene.")

func _spawn_food_random_position() -> void:
	_instantiate_food(_get_random_position())
		
func _on_food_eaten() -> void:
	food_spawn_timer.wait_time = 1
	#food_spawn_timer.timeout.connect(_spawn_food_random_position)
	food_spawn_timer.start()
	await food_spawn_timer.timeout
	_spawn_food_random_position()
