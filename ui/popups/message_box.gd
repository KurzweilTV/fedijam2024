extends CanvasLayer

@onready var label: RichTextLabel = %RichTextLabel
@onready var button: Button = %Button

var message : String

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_on_button_pressed()

func _ready() -> void:
	label.text = "[center]" + message

func _on_button_pressed() -> void:
	get_tree().paused = false
	queue_free()
