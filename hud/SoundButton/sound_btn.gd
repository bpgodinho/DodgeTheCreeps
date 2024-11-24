extends Button

@export var icons: Array[CompressedTexture2D]

@onready var background_music: AudioStreamPlayer = %BackgroundMusic
@onready var sfx: AudioStreamPlayer = %Sfx


func _on_pressed() -> void:
	var pressed = int(self.button_pressed)
	self.icon = icons[pressed]
