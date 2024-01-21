extends Node2D

class_name Level

@export var player_node: Node = null  # Initialize player_node to null

@export var food_scene: PackedScene = null
@export var foods_node: Node = null

func _ready():
	reset_level()
	if not foods_node:
		foods_node = $Fruits as Node2D  # Fallback if not set in the editor

func reset_level():
	# Reset the player
	#if fruit_node and fruit_node.is_inside_tree():
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
		
func instantiate_fruit(position: Vector2):
	if food_scene and foods_node:
		var world_position = GridUtility.grid_to_world(position)
		var food_instance = food_scene.instance()
		foods_node.add_child(food_instance)
		food_instance.position = world_position
	else:
		push_error("Food scene or foods node is not set in Level scene.")
