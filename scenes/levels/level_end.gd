extends Area2D

@export var next_level : PackedScene

@onready var animation_player: AnimationPlayer = %AnimationPlayer

func _ready() -> void:
	if ! next_level:
		next_level = preload("res://ui/main_menu/main_menu.tscn")
		
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animation_player.play_backwards("fade_animation")
		await animation_player.animation_finished
		get_tree().change_scene_to_packed(next_level)
