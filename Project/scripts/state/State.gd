class_name State
extends Node
 
signal transitioned(new_state_name: StringName)
 
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass

func Handle_input(event: InputEvent) -> void:
	pass
	
func Update(delta: float) -> void:
	pass
 
func Physics_update(delta: float) -> void:
	pass
