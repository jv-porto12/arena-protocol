extends Node2D

@onready var enemy_factory = $EnemyFactory
@onready var enemies = $Enemies
@onready var spawn_timer = $SpawnTimer
@onready var score_label = $HUD/ScoreLabel

var random = RandomNumberGenerator.new()

func _ready() -> void:
	GameManager.reset_score()
	
	GameManager.score_changed.connect(
		_on_score_changed
	)
	
	spawn_timer.timeout.connect(
		_on_spawn_timer_timeout
	)
	
func _on_spawn_timer_timeout() -> void:
	var enemy_types = [
		enemy_factory.EnemyType.NORMAL,
		enemy_factory.EnemyType.FAST,
		enemy_factory.EnemyType.TANK
	]
	
	var chosen_type = enemy_types.pick_random()
	
	var spawn_position = Vector2(
		random.randf_range(40.0, 1100.0),
		random.randf_range(40.0, 600.0)
	)
	
	var enemy = enemy_factory.create_enemy(
		chosen_type,
		spawn_position
	)
	
	enemies.add_child(enemy)
	
func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)
