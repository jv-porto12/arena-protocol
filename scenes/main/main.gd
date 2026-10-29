extends Node2D

const PlaceBeaconCommand = preload("res://scripts/commands/PlaceBeaconCommand.gd")

@onready var player = $Player
@onready var beacons = $Beacons
@onready var command_manager = $CommandManager
@onready var score_label = $HUD/ScoreLabel

func _ready() -> void:
	GameManager.reset_score()
	
	GameManager.score_changed.connect(
		_on_score_changed
	)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("place_beacon"):
		place_beacon()
	
	if Input.is_action_just_pressed("undo_action"):
		command_manager.undo_command()
		
	if Input.is_action_just_pressed("redo_action"):
		command_manager.redo_command()
	
func place_beacon() -> void:
	var command = PlaceBeaconCommand.new(
		beacons,
		player.global_position
	)
	
	command_manager.execute_command(command)

func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)
