class_name HUD
extends CanvasLayer

signal start_game

@onready var score_label: Label = $ScoreLabel
@onready var message: Label = $Message
@onready var start_button: Button = $StartButton
@onready var message_timer: Timer = $MessageTimer


func show_message(text: String) -> void:
	message.text = text
	message.show()
	message_timer.start()


func show_game_over() -> void:
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await message_timer.timeout
	
	message.text = "Dodge the\nCreeps!"
	message.show()
	
	await get_tree().create_timer(1.0).timeout
	start_button.show()


func update_score(score: int) -> void:
	score_label.text = str(score)


func _on_start_button_pressed() -> void:
	start_button.hide()
	start_game.emit()


func _on_message_timer_timeout() -> void:
	message.hide()
