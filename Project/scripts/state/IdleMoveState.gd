class_name IdleMoveState
extends State

@export var player: Player

func Handle_input(event: InputEvent):
	var player_direction: Vector2 = GridUtility.DIRECTIONS.DOWN
	
	if event.is_action_pressed("ui_up"):
		# Move up
		player_direction = GridUtility.DIRECTIONS.UP
	elif event.is_action_pressed("ui_down"):
		# Move down
		player_direction = GridUtility.DIRECTIONS.DOWN
	elif event.is_action_pressed("ui_left"):
		# Move left
		player_direction = GridUtility.DIRECTIONS.LEFT
	elif event.is_action_pressed("ui_right"):
		# Move right
		player_direction = GridUtility.DIRECTIONS.RIGHT
	
	transitioned.emit("MovingMoveState")
