extends Node

const ENEMY_SCENE: PackedScene = preload(
	"res://scenes/enemies/Enemy.tscn"
)

enum EnemyType {
	NORMAL,
	FAST,
	TANK
}

func create_enemy(
	enemy_type: EnemyType,
	spawn_position: Vector2
) -> Area2D:
	var enemy: Area2D = ENEMY_SCENE.instantiate()
	
	match enemy_type:
		
		EnemyType.NORMAL:
			enemy.move_speed = 100.0
			enemy.score_value = 10
			enemy.modulate = Color("#FF2020")
			
		EnemyType.FAST:
			enemy.move_speed = 180.0
			enemy.score_value = 20
			enemy.modulate = Color("#B22222")
			
		EnemyType.TANK:
			enemy.move_speed = 50.0
			enemy.score_value = 30
			enemy.modulate = Color("#600018")

	enemy.position = spawn_position
		
	return enemy
