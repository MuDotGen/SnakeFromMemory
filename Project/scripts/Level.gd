class_name Level
extends Node2D

@export var player_node: GridNode = null  # Initialize player_node to null

@export var food_scene: PackedScene = null
@export var foods_node: Node = null

func _ready():
	reset_level()
	if not foods_node:
		foods_node = $Foods as Node2D  # Fallback if not set in the editor

func reset_level():
	# Reset the player
	print("Resetting Level")
	if player_node:
		var player_starting_position = Vector2(GridUtility.NUM_COLUMNS / 2, GridUtility.NUM_ROWS / 2)
		print(player_starting_position)
		player_node.grid_position = player_starting_position
	#if foods_node and foods_node.is_inside_tree():
		#player_node.queue_free()
		#player_node = null  # Set player_node to null after freeing it
	
	#instantiate_player()
	pass

#func instantiate_player():
	## Instantiate the Player
	#if player_scene:
		#player_node = player_scene.instance()
		#add_child(player_node)
	#else:
		#push_error("Need to add reference to Player scene in Level scene.")
		
func instantiate_food(food_position: Vector2):
	if food_scene and foods_node:
		var world_position = GridUtility.grid_to_world(food_position)
		var food_instance = food_scene.instance()
		foods_node.add_child(food_instance)
		food_instance.position = world_position
	else:
		push_error("Food scene or foods node is not set in Level scene.")
