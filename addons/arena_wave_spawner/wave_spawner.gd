extends Node

@export var enemy_factory_path: NodePath
@export var enemy_container_path: NodePath

@export var starting_interval: float = 3.0
@export var minimum_interval: float = 0.7
@export var difficulty_step: float = 0.2
@export var difficulty_every: int = 5

@export var spawn_area: Rect2 = Rect2(
	40, 40, 1070, 560
)

var spawn_count: int = 0
var timer: Timer
var enemy_factory: Node
var enemy_container: Node2D

func _ready() -> void:
	enemy_factory = get_node_or_null(
		enemy_factory_path
	)
	
	enemy_container = get_node_or_null(
		enemy_container_path
	) as Node2D
	
	if enemy_factory == null or enemy_container == null:
		push_error("WaveSpawner: Missing node references")
		return
		
	timer = Timer.new()
	timer.wait_time = starting_interval
	
	add_child(timer)
	timer.timeout.connect(_spawn_enemy)
	timer.start()
	
func _spawn_enemy() -> void:
	var enemy_type: int = randi_range(0,2)
	
	var position_in_arena = Vector2(
		randf_range(
			spawn_area.position.x,
			spawn_area.end.x
		),
		randf_range(
			spawn_area.position.y,
			spawn_area.end.y
		)
	)
	
	var enemy = enemy_factory.create_enemy(
		enemy_type,
		position_in_arena
	)
	
	enemy_container.add_child(enemy)
	
	spawn_count += 1
	
	if spawn_count % max(difficulty_every, 1) == 0:
		timer.wait_time = max(
			minimum_interval,
			timer.wait_time - difficulty_step
		)
