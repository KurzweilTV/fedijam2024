extends TileMapLayer

var default_item_spawns

func _ready() -> void:
	default_item_spawns = self.tile_map_data
	Messages.spawn_player.connect(respawn_items)

func respawn_items() -> void:
	self.tile_map_data = default_item_spawns
