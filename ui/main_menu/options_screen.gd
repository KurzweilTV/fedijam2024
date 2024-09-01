extends Control
@onready var click: AudioStreamPlayer = $Click

@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var master_bus := AudioServer.get_bus_index("Master")
@onready var music_bus := AudioServer.get_bus_index("Music")
@onready var sfx_bus := AudioServer.get_bus_index("SFX")

@export var master_value:float = 0.8
@export var music_value:float = 0.3
@export var sfx_value:float = 0.7


func _ready() -> void:
	master_slider.value = master_value
	music_slider.value = music_value
	sfx_slider.value = sfx_value
	
	master_value = db_to_linear(AudioServer.get_bus_volume_db(master_bus))
	music_value = db_to_linear(AudioServer.get_bus_volume_db(music_bus))
	sfx_value = db_to_linear(AudioServer.get_bus_volume_db(sfx_bus))




func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(master_bus, linear_to_db(value)) 

func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))

func _on_sfx_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	click.play()
