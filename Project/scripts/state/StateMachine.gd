class_name StateMachine
extends Node

# A reusable State Machine class that allows different behavior to be handled by individual
# States such as input to move only occuring during a Moving State
 
# States
@export var current_state: State
var states: Dictionary = {}
 
func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine contains child which is not 'State'")
			
	current_state.Enter()
	
func _input(event): # For input that requires no checks for physics like whether actor is on ground
	current_state.Handle_input(event) 
			
func _process(delta): # Can check for input on every actual frame output
	current_state.Update(delta)
		
func _physics_process(delta): # Can check input as well as physics at a constant rate
	current_state.Physics_update(delta)

# Using StringName here is much faster for comparing and grabbing the correct state in a Dictionary
func on_child_transitioned(new_state_name: StringName):
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			current_state.Exit()
			new_state.Enter()
			current_state = new_state
		# Otherwise, if trying to transition to the same state, do nothing
	else:
		push_warning("Called transition on a state that does not exist")
