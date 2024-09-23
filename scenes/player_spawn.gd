class_name PlayerSpawner extends Marker2D

const Player_Scene = preload("res://actors/player/player.tscn")

func _ready() -> void:
	Messages.spawn_player.connect(spawn_player)
	spawn_player()

func spawn_player() -> void:
	var player = Player_Scene.instantiate()
	player.global_position = global_position
	get_parent().add_child.call_deferred(player)
