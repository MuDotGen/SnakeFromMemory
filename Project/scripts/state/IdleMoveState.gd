class_name IdleMoveState
extends State

@export var player: Player

func Enter():
	print("Transitioned to IdleMoveState")

# When the player is idle, they should not be moving
# As soon as the player presses a directional input,
# Change player direction and move to the moving state
func Handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		# Move up
		_change_direction(GridUtility.DIRECTIONS.UP)
	elif event.is_action_pressed("ui_down"):
		# Move down
		_change_direction(GridUtility.DIRECTIONS.DOWN)
	elif event.is_action_pressed("ui_left"):
		# Move left
		_change_direction(GridUtility.DIRECTIONS.LEFT)
	elif event.is_action_pressed("ui_right"):
		# Move right
		_change_direction(GridUtility.DIRECTIONS.RIGHT)
	
func _change_direction(direction: Vector2):
	player.current_direction = direction
	transitioned.emit("MovingMoveState")
