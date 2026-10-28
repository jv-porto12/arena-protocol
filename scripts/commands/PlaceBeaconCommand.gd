extends GameCommand

const BEACON_SCENE = preload("res://Beacon.tscn")

var beacon_parent: Node2D
var beacon_position: Vector2
var beacon_instance: Node2D

func _init(parent: Node2D, position: Vector2) -> void:
	beacon_parent = parent
	beacon_position = position
	
func execute() -> void:
	beacon_instance = BEACON_SCENE.instantiate()
	
	beacon_parent.add_child(beacon_instance)
	
	beacon_instance.position = beacon_parent.to_local(
		beacon_position
	)
	
func undo() -> void:
	if is_instance_valid(beacon_instance):
		beacon_instance.queue_free()
		beacon_instance = null
