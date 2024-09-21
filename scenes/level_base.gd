class_name BaseLevel
extends Node2D

@onready var scenes: TileMapLayer = $Layers/Scenes
@onready var fader: AnimationPlayer = %AnimationPlayer

var default_item_spawns

func _ready() -> void:
	default_item_spawns = scenes.tile_map_data
	Messages.spawn_player.connect(respawn_items)
	fader.play("fade_animation")


func respawn_items() -> void:
	scenes.tile_map_data = default_item_spawns
