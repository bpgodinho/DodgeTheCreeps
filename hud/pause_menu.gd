extends CanvasLayer

signal restart
signal resume
signal mute_music
signal mute_audio


func _on_resume_pressed() -> void:
	get_tree().paused = false
	self.hide()



func _on_restart_pressed() -> void:
	get_tree().paused = false
	self.hide()
	restart.emit()



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_music_pressed() -> void:
	mute_music.emit()


func _on_sfx_pressed() -> void:
	mute_audio.emit()
