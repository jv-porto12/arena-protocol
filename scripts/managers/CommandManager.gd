extends Node

var undo_stack: Array [GameCommand] = []
var redo_stack: Array [GameCommand] = []

func execute_command(command: GameCommand) -> void:
	command.execute()
	
	undo_stack.append(command)
	redo_stack.clear()
	
func undo_command() -> void:
	if undo_stack.is_empty():
		return
		
	var command = undo_stack.pop_back()
	
	command.undo()
	redo_stack.append(command)
	
func redo_command() -> void:
	if redo_stack.is_empty():
		return
		
	var command = redo_stack.pop_back()
	
	command.execute()
	undo_stack.append(command)
