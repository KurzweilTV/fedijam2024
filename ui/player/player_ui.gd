extends CanvasLayer

@onready var progress_bar: TextureProgressBar = %ProgressBar

func _ready() -> void:
	Player.update_water_ui.connect(update_ui)
	progress_bar.value = Player.water

func update_ui(amount: int) -> void:
	var tween = create_tween()
	tween.tween_property(progress_bar, "value", amount, 0.2)
