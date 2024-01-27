class_name PausedMoveState
extends State

#var timer: Timer
#
#func Enter():
	#print("Transitioned to Paused State")
	#timer = Timer.new()
	#add_child(timer)
	#timer.wait_time = 8 # 8 seconds
	#timer.one_shot = true
	#
	#timer.timeout.connect(_on_Timer_timeout)
	#
	## Start the timer
	#timer.start()
	#print("Started timer for 8 seconds")
#
#func Exit():
	#print("Exiting PausedMoveState")
	#if timer:
		#print("Removing Timer")
		#timer.queue_free() # This will remove the Timer node safely
	#pass
	#
#
#func _on_Timer_timeout():
	#print("Timer finished!")
	#
	## Do your timeout logic here
	#transitioned.emit("IdleMoveState")
