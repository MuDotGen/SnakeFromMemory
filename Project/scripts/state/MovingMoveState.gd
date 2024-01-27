class_name MovingMoveState
extends State

@export var player: Player

var input_times: int = 0

func Enter():
	print("Transitioned to Moving State")
	_move(player.current_direction)
	pass

func Handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		# Move up
		_move(GridUtility.DIRECTIONS.UP)
	elif event.is_action_pressed("ui_down"):
		# Move down
		_move(GridUtility.DIRECTIONS.DOWN)
	elif event.is_action_pressed("ui_left"):
		# Move left
		_move(GridUtility.DIRECTIONS.LEFT)
	elif event.is_action_pressed("ui_right"):
		# Move right
		_move(GridUtility.DIRECTIONS.RIGHT)
		
func Exit():
	print("Exiting MovingMoveState")
	input_times = 0

func _move(direction: Vector2):
	player.current_direction = direction
	var new_position: Vector2 = player.grid_position + player.current_direction
	player.grid_position = new_position
	
	input_times += 1
	if input_times > 5:
		transitioned.emit("PausedMoveState")
