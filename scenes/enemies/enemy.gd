extends Area2D

@export var move_speed: float = 100.0
@export var score_value: int = 10

var player: CharacterBody2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	player = get_tree().get_first_node_in_group("player") as CharacterBody2D
	
func _physics_process(delta: float) -> void:
	if not is_instance_valid(player):
		return
		
	var direction: Vector2 = global_position.direction_to(
		player.global_position
	)
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.add_score(score_value)
		queue_free()
