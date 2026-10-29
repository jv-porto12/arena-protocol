@tool
extends EditorPlugin

const SPAWNER_SCRIPT = preload("res://addons/arena_wave_spawner/wave_spawner.gd")

func _enter_tree() -> void:
	add_custom_type(
		"WaveSpawner",
		"Node",
		SPAWNER_SCRIPT,
		null
	)
	
func _exit_tree() -> void:
	remove_custom_type("WaveSpawner")
