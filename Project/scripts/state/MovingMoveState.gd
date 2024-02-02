class_name MovingMoveState
extends State

@export var player: Player
var snake: SnakeSegment

var movement_clock: Timer

func _ready():
	snake = player.head_snake_segment
	movement_clock = Timer.new()
	add_child(movement_clock)
	movement_clock.one_shot = true
	movement_clock.autostart = false
	movement_clock.timeout.connect(_on_movement_tick_timeout)

func Enter():
	print("Transitioned to Moving State")
	_move() # Move immediately first time
	_tick_movement_clock()
	pass
	
func Exit():
	print("Exiting MovingMoveState")
	movement_clock.stop()

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

func _move():
	var new_position: Vector2 = player.get_snake_grid_position() + player.current_direction
	# Check the new position is within a valid grid position
	new_position.x = clamp(new_position.x, 0, GridUtility.NUM_COLUMNS - 1)
	new_position.y = clamp(new_position.y, 0, GridUtility.NUM_ROWS - 1)
	player.move(new_position)
	
func _tick_movement_clock():
	movement_clock.stop()
	movement_clock.wait_time = player.movement_interval / player.speedup_factor
	movement_clock.start()
	
func _on_movement_tick_timeout():
	_move() # Move
	_tick_movement_clock() # And start another tick
