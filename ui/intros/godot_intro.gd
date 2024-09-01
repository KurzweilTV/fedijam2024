extends Control

@export var next_scene:PackedScene

@onready var video: VideoStreamPlayer = $VideoStreamPlayer

func _ready() -> void:
	video.play()
	await video.finished
	load_next_scene(next_scene)


func _input(event):
	if event is InputEventKey and event.pressed:
		load_next_scene(next_scene)
	if event is InputEventMouseButton and event.is_pressed():
		load_next_scene(next_scene)

func load_next_scene(scene) -> void:
	get_tree().change_scene_to_packed(scene)
